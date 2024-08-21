# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Street < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :ascii, :string

      xml do
        root "street"

        map_content to: :content
        map_attribute "ascii", to: :ascii
      end
    end
  end
end
