# frozen_string_literal: true

require "lutaml/model"

require_relative "back"
require_relative "front"
require_relative "link"
require_relative "middle"

module Rfcxml
  module V3
    class Rfc < Lutaml::Model::Serializable
      attribute :number, :string
      attribute :obsoletes, :string
      attribute :updates, :string
      attribute :category, :string,
                values: %w[std bcp exp info historic]
      attribute :mode, :string
      attribute :consensus, :string,
                values: %w[no yes false true],
                default: -> { "false" }
      attribute :series_no, :string
      attribute :ipr, :string
      attribute :lang, Lutaml::Xml::W3c::XmlLangType
      attribute :ipr_extract, :string
      attribute :submission_type, :string,
                values: %w[IETF IAB IRTF independent editorial],
                default: -> { "IETF" }
      attribute :doc_name, :string
      attribute :sort_refs, :string,
                values: %w[true false],
                default: -> { "false" }
      attribute :sym_refs, :string,
                values: %w[true false],
                default: -> { "true" }
      attribute :toc_include, :string,
                values: %w[true false],
                default: -> { "true" }
      attribute :toc_depth, :string, default: -> { "3" }
      attribute :prep_time, :string
      attribute :index_include, :string,
                values: %w[true false],
                default: -> { "true" }
      attribute :version, :string
      attribute :scripts, :string, default: -> { "Common,Latin" }
      attribute :expires_date, :string
      attribute :link, Link, collection: true
      attribute :front, Front
      attribute :middle, Middle
      attribute :back, Back

      xml do
        element "rfc"
        ordered

        map_attribute "number", to: :number
        map_attribute "obsoletes", to: :obsoletes,
                                   value_map: { to: { empty: :empty } }
        map_attribute "updates", to: :updates,
                                 value_map: { to: { empty: :empty } }
        map_attribute "category", to: :category
        map_attribute "mode", to: :mode
        map_attribute "consensus", to: :consensus
        map_attribute "seriesNo", to: :series_no
        map_attribute "ipr", to: :ipr
        map_attribute "iprExtract", to: :ipr_extract
        map_attribute "submissionType", to: :submission_type
        map_attribute "docName", to: :doc_name
        map_attribute "sortRefs", to: :sort_refs
        map_attribute "symRefs", to: :sym_refs
        map_attribute "tocInclude", to: :toc_include
        map_attribute "tocDepth", to: :toc_depth
        map_attribute "prepTime", to: :prep_time
        map_attribute "indexInclude", to: :index_include
        map_attribute "version", to: :version
        map_attribute "scripts", to: :scripts
        map_attribute "expiresDate", to: :expires_date
        map_attribute "lang", to: :lang

        %w[link front middle back].each do |element|
          map_element element, to: element.to_sym
        end
      end

      # Override to_xml to fix SVG elements
      # SVG elements need xmlns="http://www.w3.org/2000/svg" attribute
      # lutaml-model doesn't properly output xmlns when serializing SVG
      # and it incorrectly handles <text> elements (treats them as text content)
      def to_xml(options = {})
        xml = super
        return xml unless xml

        # Post-process to ensure SVG elements have xmlns attribute
        doc = Nokogiri::XML(xml)
        svg_needs_fix = doc.xpath("//svg[not(@xmlns)]").any? ||
          doc.xpath("//svg//*[@xmlns='http://www.w3.org/2000/svg']").any?

        return xml unless svg_needs_fix

        doc.xpath("//svg[not(@xmlns)]").each do |svg_elem|
          svg_elem["xmlns"] = "http://www.w3.org/2000/svg"
        end

        # Remove redundant xmlns from child elements within SVG
        doc.xpath("//svg//*[@xmlns='http://www.w3.org/2000/svg']").each do |child|
          child.delete("xmlns")
        end

        # Preserve XML declaration if it was in the original output
        if xml.start_with?("<?xml")
          doc.to_xml
        else
          doc.root.to_xml
        end
      end
    end
  end
end
