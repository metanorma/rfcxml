# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Format < Lutaml::Model::Serializable
      attribute :target, :string
      attribute :type, :string
      attribute :octets, :string

      xml do
        root "format"

        map_attribute "target", to: :target
        map_attribute "type", to: :type
        map_attribute "octets", to: :octets
      end
    end
  end
end
