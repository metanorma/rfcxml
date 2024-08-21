# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Email < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :ascii, :string

      xml do
        root "email"

        map_content to: :content
        map_attribute "ascii", to: :ascii
      end
    end
  end
end
