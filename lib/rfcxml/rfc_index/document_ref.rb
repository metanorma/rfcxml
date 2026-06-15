# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module RfcIndex
    class DocumentRef < Lutaml::Model::Serializable
      attribute :doc_id, :string, collection: true

      xml do
        root "documentRef"
        namespace Rfcxml::RfcIndex::Namespace

        map_element "doc-id", to: :doc_id
      end
    end
  end
end
