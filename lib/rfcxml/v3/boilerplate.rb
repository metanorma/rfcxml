# frozen_string_literal: true

require "lutaml/model"

require_relative "section"

module Rfcxml
  module V3
    class Boilerplate < Lutaml::Model::Serializable
      attribute :section, Section, collection: true

      xml do
        root "boilerplate"

        map_element "section", to: :section
      end
    end
  end
end
