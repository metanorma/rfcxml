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
      attribute :stream, :string

      xml do
        root "seriesInfo"

        map_attribute "name", to: :name
        map_attribute "value", to: :value
        map_attribute "asciiName", to: :ascii_name
        map_attribute "asciiValue", to: :ascii_value
        map_attribute "status", to: :status
        map_attribute "stream", to: :stream
      end
    end
  end
end
