# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module RfcIndex
    class Abstract < Lutaml::Model::Serializable
      attribute :p, :string, collection: true

      xml do
        root "abstract"
        namespace Rfcxml::RfcIndex::Namespace

        map_element "p", to: :p
      end
    end
  end
end
