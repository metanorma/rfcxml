# frozen_string_literal: true

require "spec_helper"

RSpec.describe Rfcxml::V3::Author do
  describe "enumeration validations" do
    it "accepts valid role value" do
      author = Rfcxml::V3::Author.new(role: "editor")
      expect(author.role).to eq("editor")
    end

    it "allows nil role" do
      author = Rfcxml::V3::Author.new
      expect(author.role).to be_nil
    end
  end

  describe "XML round-trip" do
    it "preserves role in XML" do
      author = Rfcxml::V3::Author.new(
        fullname: "Jane Doe",
        initials: "J.",
        surname: "Doe",
        role: "editor",
      )

      xml = author.to_xml(pretty: true)
      expect(xml).to include('role="editor"')

      # Round-trip
      reparsed = Rfcxml::V3::Author.from_xml(xml)
      expect(reparsed.role).to eq("editor")
      expect(reparsed.fullname).to eq("Jane Doe")
    end
  end
end
