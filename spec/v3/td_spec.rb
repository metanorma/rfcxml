# frozen_string_literal: true

require "spec_helper"

RSpec.describe Rfcxml::V3::Td do
  describe "colspan/rowspan value_map normalization" do
    it "preserves non-empty colspan and rowspan values" do
      td = described_class.new(colspan: "2", rowspan: "3")
      expect(td.colspan).to eq("2")
      expect(td.rowspan).to eq("3")
    end

    it "allows nil colspan and rowspan" do
      td = described_class.new
      expect(td.colspan).to be_nil
      expect(td.rowspan).to be_nil
    end

    it "serializes colspan and rowspan attributes" do
      td = described_class.new(colspan: "2", rowspan: "3",
                               t: [Rfcxml::V3::Text.new(content: "cell")])
      xml = td.to_xml
      expect(xml).to include('colspan="2"')
      expect(xml).to include('rowspan="3"')
    end

    it "omits colspan and rowspan when nil" do
      td = described_class.new(t: [Rfcxml::V3::Text.new(content: "cell")])
      xml = td.to_xml
      expect(xml).not_to include("colspan")
      expect(xml).not_to include("rowspan")
    end

    it "round-trips colspan and rowspan through XML" do
      xml = '<td colspan="2" rowspan="3"><t>cell</t></td>'
      td = described_class.from_xml(xml)
      expect(td.colspan).to eq("2")
      expect(td.rowspan).to eq("3")

      output = td.to_xml
      expect(output).to include('colspan="2"')
      expect(output).to include('rowspan="3"')
    end

    it "round-trips without colspan/rowspan when absent in source" do
      xml = "<td><t>cell</t></td>"
      td = described_class.from_xml(xml)
      expect(td.colspan).to be_nil
      expect(td.rowspan).to be_nil

      output = td.to_xml
      expect(output).not_to include("colspan")
      expect(output).not_to include("rowspan")
    end

    it "round-trips within a table context" do
      xml = <<~XML
        <table>
          <thead>
            <tr><th>Header</th></tr>
          </thead>
          <tbody>
            <tr><td colspan="2">wide cell</td></tr>
            <tr><td>a</td><td>b</td></tr>
          </tbody>
        </table>
      XML

      table = Rfcxml::V3::Table.from_xml(xml)
      tbody = table.tbody.is_a?(Array) ? table.tbody.first : table.tbody
      rows = tbody.tr
      expect(rows[0].td.first.colspan).to eq("2")
      expect(rows[1].td[0].colspan).to be_nil

      output = table.to_xml
      reparsed = Rfcxml::V3::Table.from_xml(output)
      rt_body = reparsed.tbody.is_a?(Array) ? reparsed.tbody.first : reparsed.tbody
      expect(rt_body.tr[0].td.first.colspan).to eq("2")
      expect(rt_body.tr[1].td[0].colspan).to be_nil
    end
  end
end
