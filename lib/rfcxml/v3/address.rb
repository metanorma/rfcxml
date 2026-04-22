# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Address < Lutaml::Model::Serializable
      attribute :postal, Postal
      attribute :phone, Phone
      attribute :facsimile, Facsimile
      attribute :email, Email, collection: true
      attribute :uri, Uri

      xml do
        element "address"

        map_element "postal", to: :postal
        map_element "phone", to: :phone
        map_element "facsimile", to: :facsimile
        map_element "email", to: :email
        map_element "uri", to: :uri
      end
    end
  end
end
