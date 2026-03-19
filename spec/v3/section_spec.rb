# frozen_string_literal: true

require "spec_helper"

RSpec.describe Rfcxml::V3::Section do
  describe "enumeration validations" do
    it "accepts valid numbered values" do
      %w[true false].each do |value|
        section = described_class.new(numbered: value)
        expect(section.numbered).to eq(value)
      end
    end

    it "accepts valid toc values" do
      %w[include exclude default].each do |value|
        section = described_class.new(toc: value)
        expect(section.toc).to eq(value)
      end
    end

    it "accepts valid remove_in_rfc values" do
      %w[true false].each do |value|
        section = described_class.new(remove_in_rfc: value)
        expect(section.remove_in_rfc).to eq(value)
      end
    end

    it "applies default values correctly" do
      section = described_class.new
      expect(section.numbered).to eq("true")
      expect(section.toc).to eq("default")
      expect(section.remove_in_rfc).to eq("false")
    end
  end

  describe "XML round-trip" do
    it "preserves enumeration values in XML" do
      section = described_class.new(
        anchor: "test-section",
        numbered: "false",
        toc: "exclude",
        remove_in_rfc: "true",
        name: Rfcxml::V3::Name.new(content: "Test Section"),
      )

      xml = section.to_xml(pretty: true)
      expect(xml).to include('numbered="false"')
      expect(xml).to include('toc="exclude"')
      expect(xml).to include('removeInRFC="true"')

      # Round-trip
      reparsed = described_class.from_xml(xml)
      expect(reparsed.numbered).to eq("false")
      expect(reparsed.toc).to eq("exclude")
      expect(reparsed.remove_in_rfc).to eq("true")
    end
  end
end
