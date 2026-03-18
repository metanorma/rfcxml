# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Organization < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :abbrev, :string
      attribute :ascii, :string
      attribute :ascii_abbrev, :string
      attribute :show_on_front_page, :string,
                values: %w[true false],
                default: -> { "true" }

      xml do
        element "organization"
        mixed_content

        map_content to: :content
        map_attribute "abbrev", to: :abbrev,
                                value_map: { to: { empty: :empty } }
        map_attribute "ascii", to: :ascii, value_map: { to: { empty: :empty } }
        map_attribute "asciiAbbrev", to: :ascii_abbrev,
                                     value_map: { to: { empty: :empty } }
        map_attribute "showOnFrontPage", to: :show_on_front_page
      end
    end
  end
end
