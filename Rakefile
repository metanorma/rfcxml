# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "open-uri"
require "rubygems/package"
require "zlib"
require "fileutils"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"

RuboCop::RakeTask.new

task default: %i[spec rubocop]

RFC_XML_URL = "https://www.rfc-editor.org/in-notes/tar/xmlsource-all.tar.gz"
RFC_XML_DIR = File.expand_path("spec/fixtures/xmlsource", __dir__)
RFC_XML_TAR = File.expand_path("tmp/xmlsource-all.tar.gz", __dir__)

namespace :rfc do
  desc "Download and extract RFC XML files from rfc-editor.org"
  task :download do
    FileUtils.mkdir_p(RFC_XML_DIR)
    FileUtils.mkdir_p(File.dirname(RFC_XML_TAR))

    # Download tarball if not exists
    unless File.exist?(RFC_XML_TAR)
      puts "Downloading RFC XML tarball from #{RFC_XML_URL}..."
      URI.open(RFC_XML_URL) do |remote|
        File.binwrite(RFC_XML_TAR, remote.read)
      end
      puts "Downloaded to #{RFC_XML_TAR}"
    end

    # Extract tarball
    puts "Extracting to #{RFC_XML_DIR}..."
    tar_extract = Gem::Package::TarReader.new(Zlib::GzipReader.open(RFC_XML_TAR))
    tar_extract.rewind
    tar_extract.each do |entry|
      next unless entry.file? && entry.full_name.end_with?(".xml")

      # Extract only the filename, flatten directory structure
      filename = File.basename(entry.full_name)
      target_path = File.join(RFC_XML_DIR, filename)

      File.binwrite(target_path, entry.read)
    end
    tar_extract.close

    xml_count = Dir.glob(File.join(RFC_XML_DIR, "*.xml")).count
    puts "Done! Extracted #{xml_count} XML files to #{RFC_XML_DIR}"
  end

  desc "Clean downloaded RFC XML files"
  task :clean do
    puts "Removing #{RFC_XML_DIR}..."
    FileUtils.rm_rf(RFC_XML_DIR)
    puts "Removing #{RFC_XML_TAR}..."
    FileUtils.rm_f(RFC_XML_TAR)
    puts "Done!"
  end

  desc "Re-download RFC XML files (clean + download)"
  task redownload: %i[clean download]
end
