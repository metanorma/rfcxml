# frozen_string_literal: true

require "lutaml/model"

require_relative "bcp14"
require_relative "xref_text"

module Rfcxml
  module V3
    class Refcontent < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :bcp14, Bcp14, collection: true
      include XrefText

      xml do
        root "refcontent"

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
