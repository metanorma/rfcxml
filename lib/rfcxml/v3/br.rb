# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Br < Lutaml::Model::Serializable
      xml do
        element "br"
      end
    end
  end
end
