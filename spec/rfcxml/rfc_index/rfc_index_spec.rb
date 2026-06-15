# frozen_string_literal: true

require "spec_helper"

RSpec.describe Rfcxml::RfcIndex::RfcIndex do
  let(:sample_xml) do
    <<~XML
      <?xml version='1.0' encoding='utf-8'?>
      <rfc-index xmlns="https://www.rfc-editor.org/rfc-index" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xsi:schemaLocation="https://www.rfc-editor.org/rfc-index https://www.rfc-editor.org/rfc-index.xsd">
        <bcp-entry>
          <doc-id>BCP3</doc-id>
          <is-also>
            <doc-id>RFC1930</doc-id>
          </is-also>
        </bcp-entry>
        <rfc-entry>
          <doc-id>RFC1</doc-id>
          <title>Host Software</title>
          <author>
            <name>S. Crocker</name>
          </author>
          <date>
            <month>April</month>
            <year>1969</year>
          </date>
          <format>
            <file-format>TXT</file-format>
            <file-format>HTML</file-format>
          </format>
          <page-count>11</page-count>
          <abstract>
            <p>Discusses host software.</p>
          </abstract>
          <obsoleted-by>
            <doc-id>RFC28</doc-id>
          </obsoleted-by>
          <current-status>UNKNOWN</current-status>
          <publication-status>UNKNOWN</publication-status>
          <stream>Legacy</stream>
          <doi>10.17487/RFC0001</doi>
        </rfc-entry>
        <std-entry>
          <doc-id>STD3</doc-id>
          <title>Host Requirements</title>
          <is-also>
            <doc-id>RFC1122</doc-id>
            <doc-id>RFC1123</doc-id>
          </is-also>
        </std-entry>
        <fyi-entry>
          <doc-id>FYI3</doc-id>
          <is-also>
            <doc-id>RFC1175</doc-id>
          </is-also>
        </fyi-entry>
        <rfc-not-issued-entry>
          <doc-id>RFC14</doc-id>
        </rfc-not-issued-entry>
      </rfc-index>
    XML
  end

  describe ".from_xml" do
    subject(:parsed) { described_class.from_xml(sample_xml) }

    it "parses all entry types" do
      expect(parsed.bcp_entry.size).to eq(1)
      expect(parsed.rfc_entry.size).to eq(1)
      expect(parsed.std_entry.size).to eq(1)
      expect(parsed.fyi_entry.size).to eq(1)
      expect(parsed.rfc_not_issued_entry.size).to eq(1)
    end

    it "parses bcp-entry fields" do
      bcp = parsed.bcp_entry.first
      expect(bcp.doc_id).to eq("BCP3")
      expect(bcp.is_also.doc_id).to eq(["RFC1930"])
    end

    it "parses rfc-entry metadata fields" do
      rfc = parsed.rfc_entry.first
      expect(rfc.doc_id).to eq("RFC1")
      expect(rfc.title).to eq("Host Software")
      expect(rfc.author.first.name).to eq("S. Crocker")
      expect(rfc.date.month).to eq("April")
      expect(rfc.date.year).to eq("1969")
      expect(rfc.format.file_format).to eq(%w[TXT HTML])
      expect(rfc.page_count).to eq("11")
      expect(rfc.abstract.p).to eq(["Discusses host software."])
    end

    it "parses rfc-entry status fields" do
      rfc = parsed.rfc_entry.first
      expect(rfc.obsoleted_by.doc_id).to eq(["RFC28"])
      expect(rfc.current_status).to eq("UNKNOWN")
      expect(rfc.stream).to eq("Legacy")
      expect(rfc.doi).to eq("10.17487/RFC0001")
    end

    it "parses std-entry fields" do
      std = parsed.std_entry.first
      expect(std.doc_id).to eq("STD3")
      expect(std.title).to eq("Host Requirements")
      expect(std.is_also.doc_id).to eq(%w[RFC1122 RFC1123])
    end

    it "parses fyi-entry fields" do
      fyi = parsed.fyi_entry.first
      expect(fyi.doc_id).to eq("FYI3")
      expect(fyi.is_also.doc_id).to eq(["RFC1175"])
    end

    it "parses rfc-not-issued-entry fields" do
      not_issued = parsed.rfc_not_issued_entry.first
      expect(not_issued.doc_id).to eq("RFC14")
    end
  end

  describe "#to_xml round-trip" do
    it "preserves all data" do
      parsed = described_class.from_xml(sample_xml)
      output = parsed.to_xml(pretty: true, declaration: true,
                             encoding: "utf-8")
      reparsed = described_class.from_xml(output)

      expect(reparsed.bcp_entry.size).to eq(1)
      expect(reparsed.rfc_entry.size).to eq(1)
      expect(reparsed.std_entry.size).to eq(1)
      expect(reparsed.fyi_entry.size).to eq(1)
      expect(reparsed.rfc_not_issued_entry.size).to eq(1)
    end

    it "is Canon-equivalent to the input" do
      parsed = described_class.from_xml(sample_xml)
      output = parsed.to_xml(pretty: true, declaration: true,
                             encoding: "utf-8")
      expect(output).to be_xml_equivalent_to(sample_xml)
        .with_profile(:spec_friendly)
    end
  end

  describe "default namespace handling" do
    it "emits xmlns once on root" do
      parsed = described_class.from_xml(sample_xml)
      output = parsed.to_xml(pretty: true, declaration: true,
                             encoding: "utf-8")
      count = output.scan('xmlns="https://www.rfc-editor.org/rfc-index"').size
      expect(count).to eq(1)
    end

    it "does not emit xmlns='' on children" do
      parsed = described_class.from_xml(sample_xml)
      output = parsed.to_xml(pretty: true, declaration: true,
                             encoding: "utf-8")
      expect(output).not_to include('xmlns=""')
    end
  end
end
