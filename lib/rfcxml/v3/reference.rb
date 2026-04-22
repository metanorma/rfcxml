# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Reference < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :derived_anchor, :string
      attribute :target, :string
      # attribute :quote_title, :string, default: -> { "true" }
      attribute :quote_title, :string
      attribute :stream, :string
      attribute :front, Front
      attribute :annotation, Annotation, collection: true
      attribute :format, Format, collection: true
      attribute :refcontent, Refcontent, collection: true
      attribute :series_info, SeriesInfo, collection: true

      xml do
        element "reference"
        mixed_content

        map_attribute "anchor", to: :anchor
        map_attribute "derivedAnchor", to: :derived_anchor
        map_attribute "target", to: :target
        map_attribute "quoteTitle", to: :quote_title
        # map_attribute "quote-title", to: :quote_title
        map_element "stream", to: :stream
        map_element "front", to: :front
        map_element "annotation", to: :annotation
        map_element "format", to: :format
        map_element "refcontent", to: :refcontent
        map_element "seriesInfo", to: :series_info
      end
    end
  end
end
