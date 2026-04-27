#!/usr/bin/env ruby
# frozen_string_literal: true

# RFC XML Round-Trip Test Script
#
# Usage:
#   ruby scripts/roundtrip_test.rb                           # All 920 files
#   ruby scripts/roundtrip_test.rb file.xml                  # Single file
#   ruby scripts/roundtrip_test.rb file1.xml file2.xml       # Multiple files
#   ruby scripts/roundtrip_test.rb "spec/*.xml"              # Glob pattern
#   ruby scripts/roundtrip_test.rb spec/xmlsource-rfc8650-latest/  # Directory
#
# Environment:
#   THREADS=n   - Number of threads (default: 8)
#   VERBOSE=1   - Show per-file progress
#
# Output:
#   tmp/roundtrip-results-{timestamp}/
#     SUMMARY.yml              - Overall summary
#     PASS_{filename}.xml      # Empty marker for passed tests
#     FAIL_{filename}.yml      # Structured failure details
#     ERROR_{filename}.yml     # Structured error details
#     SOURCE_{filename}.xml    # Round-tripped output for debugging
#

require "bundler/setup"
require "rfcxml"
require "canon"
require "yaml"
require "fileutils"
require "time"

class RoundTripTester
  DEFAULT_THREADS = 8
  DEFAULT_XML_DIR = File.expand_path("../spec/xmlsource-rfc8650-latest",
                                     __dir__)
  TMP_DIR = File.expand_path("../tmp", __dir__)

  attr_reader :results_dir

  def failed?
    @results.any? { |r| %i[fail error].include?(r[:status]) }
  end

  def initialize(files:, threads: DEFAULT_THREADS, verbose: false)
    @files = files
    @threads = threads
    @verbose = verbose
    @mutex = Mutex.new
    @processed = 0
    @results = []
    @start_time = nil

    # Create temp results directory
    timestamp = Time.now.strftime("%Y%m%d_%H%M%S")
    @results_dir = File.join(TMP_DIR, "roundtrip-results-#{timestamp}")
    FileUtils.mkdir_p(@results_dir)
  end

  def run
    puts "=" * 70
    puts "RFC XML Round-Trip Test"
    puts "=" * 70
    puts "Files:      #{@files.size}"
    puts "Threads:    #{@threads}"
    puts "Output:     #{@results_dir}"
    puts "=" * 70

    @start_time = Time.now

    if @threads == 1 || @files.size == 1
      run_sequential
    else
      run_parallel
    end

    write_summary
    print_report
  end

  private

  def run_sequential
    @files.each_with_index do |file, i|
      test_file(file)
      print "\r  Progress: #{i + 1}/#{@files.size}" unless @verbose
    end
    puts
  end

  def run_parallel
    queue = Queue.new
    @files.each { |f| queue << f }

    workers = Array.new(@threads) { Thread.new { worker(queue) } }
    monitor = Thread.new { progress_monitor(queue) }

    workers.each(&:join)
    monitor.kill
    puts
  end

  def worker(queue)
    until queue.empty?
      file = queue.pop(true)
      test_file(file)
    end
  rescue ThreadError
    # Queue empty
  end

  def test_file(filepath)
    basename = File.basename(filepath)
    result = perform_test(filepath, basename)

    @mutex.synchronize do
      @results << result
      @processed += 1
      puts "  [#{@processed}/#{@files.size}] #{result[:status].upcase}: #{basename}" if @verbose
    end
  end

  def perform_test(filepath, basename)
    # Read input
    input = begin
      File.read(filepath)
    rescue StandardError => e
      return build_error_result(basename, "Read", e)
    end

    # Parse
    parsed = begin
      Rfcxml::V3::Rfc.from_xml(input)
    rescue StandardError => e
      return build_error_result(basename, "Parse", e)
    end

    # Serialize
    output = begin
      parsed.to_xml(pretty: true, declaration: true, encoding: "utf-8")
    rescue StandardError => e
      return build_error_result(basename, "Serialize", e)
    end

    # Compare using Canon DOM diff with explicit match options
    # Using DOM diff with attribute_order: ignore and attribute_values: normalize
    # handles round-trip differences correctly
    comparison = begin
      Canon::Comparison.equivalent?(
        output,
        input,
        diff_algorithm: :dom,
        format: :xml,
        match: {
          attribute_order: :ignore,
          attribute_values: :normalize,
          text_content: :normalize,
          structural_whitespace: :ignore,
        },
        verbose: true,
      )
    rescue StandardError => e
      return build_error_result(basename, "Compare", e)
    end

    # Check result
    equivalent = comparison.respond_to?(:equivalent?) ? comparison.equivalent? : comparison

    if equivalent
      # Pass - write empty marker file
      write_pass_marker(basename)
      { file: basename, status: :pass }
    else
      # Fail - write detailed report and source
      differences = extract_differences(comparison)
      write_fail_report(basename, filepath, differences)
      write_source_output(basename, output)
      { file: basename, status: :fail, differences: differences }
    end
  end

  def build_error_result(basename, phase, error)
    error_info = {
      phase: phase,
      error_class: error.class.name,
      error_message: error.message,
      backtrace: error.backtrace&.first(5),
    }
    write_error_report(basename, error_info)
    { file: basename, status: :error, error: error_info }
  end

  def extract_differences(comparison)
    return [] unless comparison.respond_to?(:differences)

    comparison.differences.map do |diff|
      {
        path: diff.path,
        dimension: diff.dimension,
        reason: diff.reason,
        normative: diff.normative,
        formatting: diff.formatting,
        attributes_before: diff.attributes_before&.to_h,
        attributes_after: diff.attributes_after&.to_h,
      }
    end
  end

  def write_pass_marker(basename)
    path = File.join(@results_dir, "PASS_#{basename}")
    FileUtils.touch(path)
  end

  def write_fail_report(basename, source_path, differences)
    normative = differences.select { |d| d[:normative] }

    report = {
      source_file: source_path,
      status: :failed,
      normative_differences: normative.size,
      total_differences: differences.size,
      differences: normative.first(20), # Limit to first 20 normative diffs
    }

    safe_name = basename.gsub(/[^\w.-]/, "_")
    path = File.join(@results_dir, "FAIL_#{safe_name}.yml")
    File.write(path, report.to_yaml)
  end

  def write_error_report(basename, error_info)
    report = {
      source_file: basename,
      status: :error,
      **error_info,
    }

    safe_name = basename.gsub(/[^\w.-]/, "_")
    path = File.join(@results_dir, "ERROR_#{safe_name}.yml")
    File.write(path, report.to_yaml)
  end

  def write_source_output(basename, output)
    safe_name = basename.gsub(/[^\w.-]/, "_")
    path = File.join(@results_dir, "SOURCE_#{safe_name}")
    File.write(path, output)
  end

  def write_summary
    passed = @results.select { |r| r[:status] == :pass }
    failed = @results.select { |r| r[:status] == :fail }
    errors = @results.select { |r| r[:status] == :error }

    summary = {
      timestamp: Time.now.iso8601,
      configuration: {
        threads: @threads,
        files_tested: @files.size,
        elapsed_seconds: (Time.now - @start_time).round(2),
      },
      results: {
        passed: passed.size,
        failed: failed.size,
        errors: errors.size,
        pass_rate: "#{(passed.size.to_f / @files.size * 100).round(1)}%",
      },
      failed_files: failed.map { |r| r[:file] },
      error_files: errors.map { |r| r[:file] },
    }

    path = File.join(@results_dir, "SUMMARY.yml")
    File.write(path, summary.to_yaml)

    @summary = summary
  end

  def print_report
    elapsed = Time.now - @start_time
    passed = @results.count { |r| r[:status] == :pass }
    failed = @results.count { |r| r[:status] == :fail }
    errors = @results.count { |r| r[:status] == :error }

    puts
    puts "=" * 70
    puts "RESULTS"
    puts "=" * 70
    puts "Elapsed:    #{elapsed.round(2)}s"
    puts "PASSED:     #{passed}/#{@files.size} (#{pct(passed)}%)"
    puts "FAILED:     #{failed}/#{@files.size} (#{pct(failed)}%)"
    puts "ERRORS:     #{errors}/#{@files.size} (#{pct(errors)}%)"
    puts
    puts "Output dir: #{@results_dir}"

    if failed.positive? || errors.positive?
      puts
      puts "See #{@results_dir}/ for detailed reports:"
      puts "  FAIL_*.yml    - Failure details"
      puts "  ERROR_*.yml   - Error details"
      puts "  SOURCE_*.xml  - Round-tripped output"
    end
  end

  def pct(count)
    return 0.0 if @files.empty?

    (count.to_f / @files.size * 100).round(1)
  end

  def progress_monitor(_queue)
    loop do
      sleep 1
      @mutex.synchronize do
        return if @processed >= @files.size

        print "\r  Progress: #{@processed}/#{@files.size} (#{pct(@processed)}%)    "
        $stdout.flush
      end
    end
  end
end

# === CLI Argument Parsing ===

def parse_args(args)
  threads = ENV.fetch("THREADS", RoundTripTester::DEFAULT_THREADS).to_i
  verbose = ENV["VERBOSE"] || ENV.fetch("V", nil)

  files = []

  args.each do |arg|
    if File.directory?(arg)
      files.concat(Dir.glob(File.join(arg, "*.xml")))
    elsif File.file?(arg)
      files << File.expand_path(arg)
    elsif arg.include?("*")
      files.concat(Dir.glob(arg))
    else
      # Try as file path
      path = File.expand_path(arg)
      files << path if File.file?(path)
    end
  end

  # Default: all files in default directory
  if files.empty?
    files = Dir.glob(File.join(RoundTripTester::DEFAULT_XML_DIR, "*.xml"))
  end

  files = files.sort.uniq

  { files: files, threads: threads, verbose: verbose }
end

# === Main ===

if __FILE__ == $PROGRAM_NAME
  options = parse_args(ARGV)

  if options[:files].empty?
    puts "No XML files found"
    exit 1
  end

  tester = RoundTripTester.new(**options)
  tester.run

  exit 1 if tester.failed?
end
