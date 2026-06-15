# frozen_string_literal: true

require "lutaml/model"

require_relative "document_ref"

module Rfcxml
  module RfcIndex
    class StdEntry < Lutaml::Model::Serializable
      attribute :doc_id, :string
      attribute :title, :string
      attribute :is_also, DocumentRef

      xml do
        root "std-entry"
        namespace Rfcxml::RfcIndex::Namespace

        map_element "doc-id", to: :doc_id
        map_element "title", to: :title
        map_element "is-also", to: :is_also
      end
    end
  end
end
