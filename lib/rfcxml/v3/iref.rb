# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Iref < Lutaml::Model::Serializable
      attribute :item, :string
      attribute :subitem, :string, default: -> { "" }
      attribute :primary, :string, default: -> { "false" }
      attribute :pn, :string

      xml do
        root "iref"

        map_attribute "item", to: :item
        map_attribute "subitem", to: :subitem
        map_attribute "primary", to: :primary
        map_attribute "pn", to: :pn
      end
    end
  end
end
