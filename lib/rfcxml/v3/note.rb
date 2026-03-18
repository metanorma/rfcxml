# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Note < Lutaml::Model::Serializable
      attribute :title, :string
      attribute :pn, :string
      attribute :remove_in_rfc, :string, default: -> { "false" }
      attribute :name, Name
      attribute :dl, Dl, collection: true
      attribute :ol, Ol, collection: true
      attribute :t, Text, collection: true
      attribute :ul, Ul, collection: true

      xml do
        element "note"
        ordered

        map_attribute "title", to: :title
        map_attribute "pn", to: :pn
        map_attribute "removeInRFC", to: :remove_in_rfc
        map_element "name", to: :name
        map_element "dl", to: :dl
        map_element "ol", to: :ol
        map_element "t", to: :t
        map_element "ul", to: :ul
      end
    end
  end
end
