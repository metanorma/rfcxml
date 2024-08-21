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
        root "date"

        map_content to: :content
        map_attribute "day", to: :day
        map_attribute "month", to: :month
        map_attribute "year", to: :year
      end
    end
  end
end
