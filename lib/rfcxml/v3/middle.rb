# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Middle < Lutaml::Model::Serializable
      attribute :section, Section, collection: true

      xml do
        element "middle"

        map_element "section", to: :section
      end
    end
  end
end
