# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Front < Lutaml::Model::Serializable
      attribute :title, Title
      attribute :series_info, SeriesInfo, collection: true
      attribute :author, Author, collection: true
      attribute :date, Date
      attribute :area, Area, collection: true
      attribute :workgroup, Workgroup, collection: true
      attribute :keyword, Keyword, collection: true
      attribute :abstract, Abstract
      attribute :note, Note, collection: true
      attribute :boilerplate, Boilerplate
      attribute :toc, Toc

      xml do
        root "front"

        map_element "title", to: :title
        map_element "seriesInfo", to: :series_info
        map_element "author", to: :author
        map_element "date", to: :date
        map_element "area", to: :area
        map_element "workgroup", to: :workgroup
        map_element "keyword", to: :keyword
        map_element "abstract", to: :abstract
        map_element "note", to: :note
        map_element "boilerplate", to: :boilerplate
        map_element "toc", to: :toc
      end
    end
  end
end
