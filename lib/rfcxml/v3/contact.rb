# frozen_string_literal: true

require "lutaml/model"

require_relative "address"
require_relative "organization"

module Rfcxml
  module V3
    class Contact < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :initials, :string
      attribute :ascii_initials, :string
      attribute :surname, :string
      attribute :ascii_surname, :string
      attribute :fullname, :string
      attribute :ascii_fullname, :string
      attribute :organization, Organization
      attribute :address, Address

      xml do
        root "contact"

        map_attribute "anchor", to: :anchor
        map_attribute "initials", to: :initials
        map_attribute "asciiInitials", to: :ascii_initials
        map_attribute "surname", to: :surname
        map_attribute "asciiSurname", to: :ascii_surname
        map_attribute "fullname", to: :fullname
        map_attribute "asciiFullname", to: :ascii_fullname
        map_element "organization", to: :organization
        map_element "address", to: :address
      end
    end
  end
end
