# frozen_string_literal: true

require "lutaml/model"

require_relative "artwork"

module Rfcxml
  module V3
    class Artset < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :pn, :string
      attribute :artwork, Artwork, collection: true

      xml do
        root "artset"

        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_element "artwork", to: :artwork
      end
    end
  end
end
