# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module RfcIndex
    class RfcNotIssuedEntry < Lutaml::Model::Serializable
      attribute :doc_id, :string

      xml do
        root "rfc-not-issued-entry"
        namespace Rfcxml::RfcIndex::Namespace

        map_element "doc-id", to: :doc_id
      end
    end
  end
end
