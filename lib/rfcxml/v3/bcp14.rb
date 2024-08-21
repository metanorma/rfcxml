# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Bcp14 < Lutaml::Model::Serializable
      attribute :content, :string

      xml do
        root "bcp14"

        map_content to: :content
      end
    end
  end
end
