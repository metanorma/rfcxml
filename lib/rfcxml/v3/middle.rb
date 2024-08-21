# frozen_string_literal: true

require "lutaml/model"

require_relative "section"

module Rfcxml
  module V3
    class Middle < Lutaml::Model::Serializable
      attribute :section, Section, collection: true

      xml do
        root "middle"

        map_element "section", to: :section
      end
    end
  end
end
