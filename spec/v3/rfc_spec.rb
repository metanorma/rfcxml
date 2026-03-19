# frozen_string_literal: true

RSpec.describe Rfcxml::V3::Rfc do
  # These files come from https://www.rfc-editor.org/retrieve/bulk/
  def file_contents(filename)
    File.read(filename)
  end

  # ============================================================================
  # Enumeration Validation Tests
  # ============================================================================
  describe "enumeration validations" do
    it "accepts valid category values" do
      %w[std bcp exp info historic].each do |value|
        rfc = described_class.new(category: value)
        expect(rfc.category).to eq(value)
      end
    end

    it "accepts valid consensus values" do
      %w[no yes false true].each do |value|
        rfc = described_class.new(consensus: value)
        expect(rfc.consensus).to eq(value)
      end
    end

    it "accepts valid submission_type values" do
      %w[IETF IAB IRTF independent editorial].each do |value|
        rfc = described_class.new(submission_type: value)
        expect(rfc.submission_type).to eq(value)
      end
    end

    it "applies default values correctly" do
      rfc = described_class.new
      expect(rfc.consensus).to eq("false")
      expect(rfc.submission_type).to eq("IETF")
      expect(rfc.sort_refs).to eq("false")
      expect(rfc.sym_refs).to eq("true")
      expect(rfc.toc_include).to eq("true")
      expect(rfc.index_include).to eq("true")
    end
  end

  glob_path = Pathname.new(__dir__)
    .join("../xmlsource-rfc8650-latest/*.xml")

  Dir.glob(glob_path)[0..1].each do |filename|
    fn = Pathname.new(filename).basename

    it "parses #{fn} and produces valid XML output" do
      input = file_contents(Pathname.new(filename))

      # Verify parsing works
      parsed = described_class.from_xml(input)
      expect(parsed).to be_a(described_class)

      # Verify serialization produces valid XML
      output = parsed.to_xml(
        pretty: true,
        declaration: true,
        encoding: "utf-8",
      )

      # Verify output can be re-parsed
      reparsed = described_class.from_xml(output)
      expect(reparsed).to be_a(described_class)
    end

    # Round-trip test: parse XML, serialize back, compare semantically
    # Namespace declarations (xmlns:*) are preserved during round-trip
    it "round-trips #{fn} preserving XML structure" do
      input = file_contents(Pathname.new(filename))
      parsed = described_class.from_xml(input)
      output = parsed.to_xml(
        pretty: true,
        declaration: true,
        encoding: "utf-8",
      )

      # Use Canon's RSpec matcher for semantic comparison
      # spec_friendly profile: normalizes text, ignores whitespace
      # and attribute order
      expect(output).to be_xml_equivalent_to(input)
        .with_profile(:spec_friendly)
    end
  end
end
