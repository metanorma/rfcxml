# frozen_string_literal: true

require "spec_helper"

RSpec.describe Rfcxml::V3::Rfc do
  describe "processing instruction (pi) settings" do
    it "parses processing instructions into pi_settings hash" do
      xml = <<~XML
        <?rfc toc="yes"?>
        <?rfc compact="yes"?>
        <rfc version="3">
          <front>
            <title>Test</title>
            <author fullname="Test Author"/>
            <date year="2025"/>
          </front>
          <middle>
            <section><t>Content.</t></section>
          </middle>
        </rfc>
      XML

      rfc = described_class.from_xml(xml)
      expect(rfc.pi_settings).to be_a(Hash)
      expect(rfc.pi_settings["toc"]).to eq("yes")
      expect(rfc.pi_settings["compact"]).to eq("yes")
    end

    it "returns uninitialized pi_settings when no PIs present" do
      xml = <<~XML
        <rfc version="3">
          <front>
            <title>Test</title>
            <author fullname="Test Author"/>
            <date year="2025"/>
          </front>
          <middle>
            <section><t>Content.</t></section>
          </middle>
        </rfc>
      XML

      rfc = described_class.from_xml(xml)
      # lutaml-model returns uninitialized sentinel for unset attributes
      expect { rfc.pi_settings }.not_to raise_error
    end

    it "serializes pi_settings back as processing instructions" do
      rfc = described_class.new(
        version: "3",
        pi_settings: { "toc" => "yes", "sym_refs" => "true" },
        front: Rfcxml::V3::Front.new(
          title: Rfcxml::V3::Title.new(content: "Test"),
          author: [Rfcxml::V3::Author.new(fullname: "Test Author")],
          date: Rfcxml::V3::Date.new(year: "2025"),
        ),
        middle: Rfcxml::V3::Middle.new(
          section: [Rfcxml::V3::Section.new(t: [Rfcxml::V3::Text.new(content: "Content.")])],
        ),
      )

      xml = rfc.to_xml(pretty: true, declaration: true, encoding: "utf-8")
      expect(xml).to include('<?rfc toc="yes"?>')
      expect(xml).to include('<?rfc sym_refs="true"?>')
    end

    it "round-trips processing instructions" do
      xml = <<~XML
        <?rfc toc="yes"?>
        <?rfc sort_refs="true"?>
        <?rfc compact="yes"?>
        <rfc version="3" ipr="trust200902" category="info">
          <front>
            <title>Test Document</title>
            <author fullname="Test Author"/>
            <date year="2025"/>
          </front>
          <middle>
            <section><t>Content.</t></section>
          </middle>
        </rfc>
      XML

      parsed = described_class.from_xml(xml)
      expect(parsed.pi_settings).to eq({ "toc" => "yes", "sort_refs" => "true",
                                         "compact" => "yes" })

      output = parsed.to_xml(pretty: true, declaration: true, encoding: "utf-8")
      expect(output).to include('<?rfc toc="yes"?>')
      expect(output).to include('<?rfc sort_refs="true"?>')
      expect(output).to include('<?rfc compact="yes"?>')

      reparsed = described_class.from_xml(output)
      expect(reparsed.pi_settings).to eq({ "toc" => "yes",
                                           "sort_refs" => "true", "compact" => "yes" })
    end
  end
end
