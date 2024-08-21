# frozen_string_literal: true

require "lutaml/model"

require_relative "br"

module Rfcxml
  module V3
    class Title < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :abbrev, :string
      attribute :ascii, :string
      attribute :br, Br, collection: true

      xml do
        root "title"

        map_content to: :content
        map_attribute "abbrev", to: :abbrev
        map_attribute "ascii", to: :ascii
        map_element "br", to: :br
      end
    end
  end
end
