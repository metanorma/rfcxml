# frozen_string_literal: true

require "lutaml/model"

require_relative "xref_text"

module Rfcxml
  module V3
    class Xref < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :target, :string
      attribute :pageno, :string, default: -> { "false" }
      attribute :format, :string, default: -> { "default" }
      attribute :derived_content, :string
      attribute :section_format, :string, default: -> { "of" }
      attribute :section, :string
      attribute :relative, :string
      attribute :derived_link, :string
      include XrefText

      xml do
        root "xref"

        map_content to: :content
        map_attribute "target", to: :target
        map_attribute "pageno", to: :pageno
        map_attribute "format", to: :format
        map_attribute "derivedContent", to: :derived_content
        map_attribute "sectionFormat", to: :section_format
        map_attribute "section", to: :section
        map_attribute "relative", to: :relative
        map_attribute "derivedLink", to: :derived_link
        map_element "em", to: :em
        map_element "strong", to: :strong
        map_element "sub", to: :sub
        map_element "sup", to: :sup
        map_element "tt", to: :tt
      end
    end
  end
end
