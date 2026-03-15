# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Back < Lutaml::Model::Serializable
      attribute :displayreference, Displayreference, collection: true
      attribute :references, References, collection: true
      attribute :section, Section, collection: true

      xml do
        root "back"

        map_element "displayreference", to: :displayreference
        map_element "references", to: :references
        map_element "section", to: :section
      end
    end
  end
end
