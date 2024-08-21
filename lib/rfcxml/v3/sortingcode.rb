# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Sortingcode < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :ascii, :string

      xml do
        root "sortingcode"

        map_content to: :content
        map_attribute "ascii", to: :ascii
      end
    end
  end
end
