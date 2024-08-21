# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Relref < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :target, :string
      attribute :display_format, :string, default: -> { "of" }
      attribute :derived_content, :string
      attribute :section, :string
      attribute :relative, :string
      attribute :derived_link, :string

      xml do
        root "relref"

        map_content to: :content
        map_attribute "target", to: :target
        map_attribute "displayFormat", to: :display_format
        map_attribute "derivedContent", to: :derived_content
        map_attribute "section", to: :section
        map_attribute "relative", to: :relative
        map_attribute "derivedLink", to: :derived_link
      end
    end
  end
end
