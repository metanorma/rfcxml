# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Displayreference < Lutaml::Model::Serializable
      attribute :target, :string
      attribute :to, :string

      xml do
        root "displayreference"

        map_attribute "target", to: :target
        map_attribute "to", to: :to
      end
    end
  end
end
