# frozen_string_literal: true

require "spec_helper"

RSpec.describe Rfcxml::V3::Cref do
  describe "inline element collections" do
    it "holds strong inline elements" do
      strong = Rfcxml::V3::Strong.new(content: ["important"])
      cref = described_class.new(content: "see ", strong: [strong])
      expect(cref.strong.size).to eq(1)
      expect(cref.strong.first.content).to eq(["important"])
    end

    it "holds tt inline elements" do
      tt = Rfcxml::V3::Tt.new(content: ["code"])
      cref = described_class.new(content: "use ", tt: [tt])
      expect(cref.tt.size).to eq(1)
      expect(cref.tt.first.content).to eq(["code"])
    end

    it "parses XML with inline elements" do
      xml = '<cref source="editor">Use <strong>MUST</strong> and <tt>code</tt> here</cref>'
      cref = described_class.from_xml(xml)
      expect(cref.source).to eq("editor")
      expect(cref.strong.size).to eq(1)
      expect(cref.tt.size).to eq(1)
      expect(cref.strong.first.content).to eq("MUST")
      expect(cref.tt.first.content).to eq("code")
    end

    it "round-trips cref with inline elements" do
      xml = '<cref anchor="note-1" source="editor">Check <em>this</em> and <sub>n</sub></cref>'
      cref = described_class.from_xml(xml)

      output = cref.to_xml
      expect(output).to include("<em>this</em>")
      expect(output).to include("<sub>n</sub>")
      expect(output).to include('anchor="note-1"')
      expect(output).to include('source="editor"')
    end

    it "loads without NameError regardless of require order" do
      # The string type references ("Rfcxml::V3::Strong" etc.)
      # ensure no NameError even if Strong/Sub/Sup/Tt haven't
      # been autoloaded yet.
      expect { load("#{__dir__}/../../lib/rfcxml/v3/cref.rb") }.not_to raise_error
    end
  end
end
