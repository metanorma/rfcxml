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
      attribute :obsoletes, :string, default: -> { "" }
      attribute :updates, :string, default: -> { "" }
      attribute :category, :string
      attribute :mode, :string
      attribute :consensus, :string, default: -> { "false" }
      attribute :series_no, :string
      attribute :ipr, :string
      attribute :lang, :string
      attribute :ipr_extract, :string
      attribute :submission_type, :string, default: -> { "IETF" }
      attribute :doc_name, :string
      attribute :sort_refs, :string, default: -> { "false" }
      attribute :sym_refs, :string, default: -> { "true" }
      attribute :toc_include, :string, default: -> { "true" }
      attribute :toc_depth, :string, default: -> { "3" }
      attribute :prep_time, :string
      attribute :index_include, :string, default: -> { "true" }
      attribute :version, :string
      attribute :scripts, :string, default: -> { "Common,Latin" }
      attribute :expires_date, :string
      attribute :link, Link, collection: true
      attribute :front, Front
      attribute :middle, Middle
      attribute :back, Back

      xml do
        root "rfc"

        map_attribute "number", to: :number
        map_attribute "obsoletes", to: :obsoletes
        map_attribute "updates", to: :updates
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
        map_attribute "lang", to: :lang, prefix: :xml
        map_element "link", to: :link
        map_element "front", to: :front
        map_element "middle", to: :middle
        map_element "back", to: :back
      end
    end
  end
end
