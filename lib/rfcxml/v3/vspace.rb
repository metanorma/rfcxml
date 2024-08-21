# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Vspace < Lutaml::Model::Serializable
      attribute :blank_lines, :string, default: -> { "0" }

      xml do
        root "vspace"

        map_attribute "blankLines", to: :blank_lines
      end
    end
  end
end
