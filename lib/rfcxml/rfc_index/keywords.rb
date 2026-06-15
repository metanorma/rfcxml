# frozen_string_literal: true

require "lutaml/model"

require_relative "kw"

module Rfcxml
  module RfcIndex
    class Keywords < Lutaml::Model::Serializable
      attribute :kw, Kw, collection: true

      xml do
        root "keywords"
        namespace Rfcxml::RfcIndex::Namespace

        map_element "kw", to: :kw
      end
    end
  end
end
