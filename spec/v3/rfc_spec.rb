# frozen_string_literal: true

RSpec.describe Rfcxml::V3::Rfc do
  # These files come from https://www.rfc-editor.org/retrieve/bulk/
  def file_contents(filename)
    File.read(filename)
  end

  glob_path = Pathname.new(__dir__)
    .join("../xmlsource-rfc8650-latest/*.xml")

  Dir.glob(glob_path)[0..1].each do |filename|
    fn = Pathname.new(filename).basename

    it "parses #{fn} and produces valid XML output" do
      input = file_contents(Pathname.new(filename))

      # Verify parsing works
      parsed = Rfcxml::V3::Rfc.from_xml(input)
      expect(parsed).to be_a(Rfcxml::V3::Rfc)

      # Verify serialization produces valid XML
      output = parsed.to_xml(
        pretty: true,
        declaration: true,
        encoding: "utf-8",
      )

      # Verify output can be re-parsed
      reparsed = Rfcxml::V3::Rfc.from_xml(output)
      expect(reparsed).to be_a(Rfcxml::V3::Rfc)
    end

    # Round-trip test: parse XML, serialize back, compare semantically
    # Namespace declarations (xmlns:*) are preserved during round-trip
    it "round-trips #{fn} preserving XML structure" do
      input = file_contents(Pathname.new(filename))
      parsed = Rfcxml::V3::Rfc.from_xml(input)
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
