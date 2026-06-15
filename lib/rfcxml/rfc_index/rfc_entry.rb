# frozen_string_literal: true

require "lutaml/model"

require_relative "author"
require_relative "date"
require_relative "format"
require_relative "keywords"
require_relative "abstract"
require_relative "document_ref"

module Rfcxml
  module RfcIndex
    class RfcEntry < Lutaml::Model::Serializable
      attribute :doc_id, :string
      attribute :title, :string
      attribute :author, Author, collection: true
      attribute :date, Date
      attribute :format, Format
      attribute :page_count, :string
      attribute :keywords, Keywords
      attribute :abstract, Abstract
      attribute :draft, :string
      attribute :notes, :string
      attribute :obsoletes, DocumentRef
      attribute :obsoleted_by, DocumentRef
      attribute :updates, DocumentRef
      attribute :updated_by, DocumentRef
      attribute :is_also, DocumentRef
      attribute :see_also, DocumentRef
      attribute :current_status, :string
      attribute :publication_status, :string
      attribute :stream, :string
      attribute :area, :string
      attribute :wg_acronym, :string
      attribute :errata_url, :string
      attribute :doi, :string

      xml do
        root "rfc-entry"
        namespace Rfcxml::RfcIndex::Namespace
        ordered

        map_element "doc-id", to: :doc_id
        map_element "title", to: :title
        map_element "author", to: :author
        map_element "date", to: :date
        map_element "format", to: :format
        map_element "page-count", to: :page_count
        map_element "keywords", to: :keywords
        map_element "abstract", to: :abstract
        map_element "draft", to: :draft
        map_element "notes", to: :notes
        map_element "obsoletes", to: :obsoletes
        map_element "obsoleted-by", to: :obsoleted_by
        map_element "updates", to: :updates
        map_element "updated-by", to: :updated_by
        map_element "is-also", to: :is_also
        map_element "see-also", to: :see_also
        map_element "current-status", to: :current_status
        map_element "publication-status", to: :publication_status
        map_element "stream", to: :stream
        map_element "area", to: :area
        map_element "wg_acronym", to: :wg_acronym
        map_element "errata-url", to: :errata_url
        map_element "doi", to: :doi
      end
    end
  end
end
