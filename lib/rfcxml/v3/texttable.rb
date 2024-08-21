# frozen_string_literal: true

require "lutaml/model"

require_relative "c"
require_relative "name"
require_relative "postamble"
require_relative "preamble"
require_relative "ttcol"

module Rfcxml
  module V3
    class Texttable < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :title, :string, default: -> { "" }
      attribute :suppress_title, :string, default: -> { "false" }
      attribute :align, :string, default: -> { "center" }
      attribute :style, :string, default: -> { "full" }
      attribute :name, Name
      attribute :preamble, Preamble
      attribute :ttcol, Ttcol, collection: true
      attribute :c, C, collection: true
      attribute :postamble, Postamble

      xml do
        root "texttable"

        map_attribute "anchor", to: :anchor
        map_attribute "title", to: :title
        map_attribute "suppress-title", to: :suppress_title
        map_attribute "align", to: :align
        map_attribute "style", to: :style
        map_element "name", to: :name
        map_element "preamble", to: :preamble
        map_element "ttcol", to: :ttcol
        map_element "c", to: :c
        map_element "postamble", to: :postamble
      end
    end
  end
end
