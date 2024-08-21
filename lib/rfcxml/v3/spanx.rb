# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Spanx < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :style, :string, default: -> { "emph" }

      xml do
        root "spanx"

        map_content to: :content
        map_attribute "style", to: :style
      end
    end
  end
end
