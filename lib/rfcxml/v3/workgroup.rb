# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Workgroup < Lutaml::Model::Serializable
      attribute :content, :string

      xml do
        root "workgroup"

        map_content to: :content
      end
    end
  end
end
