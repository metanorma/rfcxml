# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Phone < Lutaml::Model::Serializable
      attribute :content, :string

      xml do
        root "phone"

        map_content to: :content
      end
    end
  end
end
