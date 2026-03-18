# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Author < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :initials, :string
      attribute :ascii_initials, :string
      attribute :surname, :string
      attribute :ascii_surname, :string
      attribute :fullname, :string
      attribute :role, :string, values: %w[editor]
      attribute :ascii_fullname, :string
      attribute :organization, Organization
      attribute :address, Address

      xml do
        element "author"
        ordered

        map_attribute "anchor", to: :anchor
        map_attribute "initials", to: :initials,
                                  value_map: { to: { empty: :empty } }
        map_attribute "asciiInitials", to: :ascii_initials,
                                       value_map: { to: { empty: :empty } }
        map_attribute "surname", to: :surname,
                                 value_map: { to: { empty: :empty } }
        map_attribute "asciiSurname", to: :ascii_surname,
                                      value_map: { to: { empty: :empty } }
        map_attribute "fullname", to: :fullname,
                                  value_map: { to: { empty: :empty } }
        map_attribute "role", to: :role, value_map: { to: { empty: :empty } }
        map_attribute "asciiFullname", to: :ascii_fullname,
                                       value_map: { to: { empty: :empty } }
        map_element "organization", to: :organization
        map_element "address", to: :address
      end
    end
  end
end
