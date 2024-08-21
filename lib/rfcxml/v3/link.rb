# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Link < Lutaml::Model::Serializable
      attribute :href, :string
      attribute :rel, :string

      xml do
        root "link"

        map_attribute "href", to: :href
        map_attribute "rel", to: :rel
      end
    end
  end
end
