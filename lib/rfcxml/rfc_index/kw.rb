# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module RfcIndex
    class Kw < Lutaml::Model::Serializable
      attribute :content, :string

      xml do
        root "kw"
        namespace Rfcxml::RfcIndex::Namespace

        map_content to: :content
      end
    end
  end
end
