# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Eref < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :brackets, :string, default: -> { "none" }
      attribute :target, :string

      xml do
        root "eref"

        map_content to: :content
        map_attribute "brackets", to: :brackets
        map_attribute "target", to: :target
      end
    end
  end
end
