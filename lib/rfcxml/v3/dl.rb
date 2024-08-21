# frozen_string_literal: true

require "lutaml/model"

# require_relative "dd"
# require_relative "dt"

module Rfcxml
  module V3
    class Dd < Lutaml::Model::Serializable; end
    class Dt < Lutaml::Model::Serializable; end

    class Dl < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :spacing, :string, default: -> { "normal" }
      attribute :newline, :string, default: -> { "false" }
      attribute :indent, :string, default: -> { "3" }
      attribute :pn, :string
      attribute :dt, Dt, collection: true
      attribute :dd, Dd, collection: true

      xml do
        root "dl"

        map_attribute "anchor", to: :anchor
        map_attribute "spacing", to: :spacing
        map_attribute "newline", to: :newline
        map_attribute "indent", to: :indent
        map_attribute "pn", to: :pn
        map_element "dt", to: :dt
        map_element "dd", to: :dd
      end
    end
  end
end
