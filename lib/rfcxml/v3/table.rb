# frozen_string_literal: true

require "lutaml/model"

require_relative "iref"
require_relative "name"
require_relative "tbody"
require_relative "tfoot"
require_relative "thead"

module Rfcxml
  module V3
    class Table < Lutaml::Model::Serializable
      attribute :align, :string, default: -> { "center" }
      attribute :anchor, :string
      attribute :pn, :string
      attribute :name, Name
      attribute :iref, Iref, collection: true
      attribute :thead, Thead
      attribute :tbody, Tbody, collection: true
      attribute :tfoot, Tfoot

      xml do
        root "table"

        map_attribute "align", to: :align
        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_element "name", to: :name
        map_element "iref", to: :iref
        map_element "thead", to: :thead
        map_element "tbody", to: :tbody
        map_element "tfoot", to: :tfoot
      end
    end
  end
end
