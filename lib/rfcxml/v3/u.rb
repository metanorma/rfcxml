# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class U < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :ascii, :string
      attribute :format, :string, default: -> { "lit-name-num" }
      attribute :pn, :string

      xml do
        root "u"

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "ascii", to: :ascii
        map_attribute "format", to: :format
        map_attribute "pn", to: :pn
      end
    end
  end
end
