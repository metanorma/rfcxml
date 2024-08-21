# frozen_string_literal: true

require "lutaml/model"

require_relative "city"
require_relative "cityarea"
require_relative "code"
require_relative "country"
require_relative "extaddr"
require_relative "pobox"
require_relative "postal_line"
require_relative "region"
require_relative "sortingcode"
require_relative "street"

module Rfcxml
  module V3
    class Postal < Lutaml::Model::Serializable
      attribute :city, City, collection: true
      attribute :cityarea, Cityarea, collection: true
      attribute :code, Code, collection: true
      attribute :country, Country, collection: true
      attribute :extaddr, Extaddr, collection: true
      attribute :pobox, Pobox, collection: true
      attribute :region, Region, collection: true
      attribute :sortingcode, Sortingcode, collection: true
      attribute :street, Street, collection: true
      attribute :postal_line, PostalLine, collection: true

      xml do
        root "postal"

        map_element "city", to: :city
        map_element "cityarea", to: :cityarea
        map_element "code", to: :code
        map_element "country", to: :country
        map_element "extaddr", to: :extaddr
        map_element "pobox", to: :pobox
        map_element "region", to: :region
        map_element "sortingcode", to: :sortingcode
        map_element "street", to: :street
        map_element "postalLine", to: :postal_line
      end
    end
  end
end
