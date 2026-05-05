# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Refcontent < Lutaml::Model::Serializable
      attribute :content, :string, collection: true
      attribute :bcp14, Bcp14, collection: true
      include XrefText

      xml do
        element "refcontent"
        mixed_content

        map_content to: :content
        map_element "bcp14", to: :bcp14
        map_element "em", to: :em
        map_element "strong", to: :strong
        map_element "sub", to: :sub
        map_element "sup", to: :sup
        map_element "tt", to: :tt
      end
    end
  end
end
