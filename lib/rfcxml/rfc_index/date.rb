# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module RfcIndex
    class Date < Lutaml::Model::Serializable
      attribute :month, :string
      attribute :day, :string
      attribute :year, :string

      xml do
        root "date"
        namespace Rfcxml::RfcIndex::Namespace

        map_element "month", to: :month
        map_element "day", to: :day
        map_element "year", to: :year
      end
    end
  end
end
