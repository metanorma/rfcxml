# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class SeriesInfo < Lutaml::Model::Serializable
      attribute :name, :string
      attribute :value, :string
      attribute :ascii_name, :string
      attribute :ascii_value, :string
      attribute :status, :string
      attribute :stream, :string,
                values: %w[IETF IAB IRTF independent editorial]

      xml do
        element "seriesInfo"

        map_attribute "name", to: :name, value_map: { to: { empty: :empty } }
        map_attribute "value", to: :value, value_map: { to: { empty: :empty } }
        map_attribute "asciiName", to: :ascii_name
        map_attribute "asciiValue", to: :ascii_value
        map_attribute "status", to: :status
        map_attribute "stream", to: :stream
      end
    end
  end
end
