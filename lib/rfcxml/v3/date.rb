# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Date < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :day, :string
      attribute :month, :string
      attribute :year, :string

      xml do
        element "date"

        map_content to: :content
        map_attribute "day", to: :day, value_map: { to: { empty: :empty } }
        map_attribute "month", to: :month, value_map: { to: { empty: :empty } }
        map_attribute "year", to: :year, value_map: { to: { empty: :empty } }
      end
    end
  end
end
