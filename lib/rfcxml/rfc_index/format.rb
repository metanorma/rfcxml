# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module RfcIndex
    class Format < Lutaml::Model::Serializable
      attribute :file_format, :string, collection: true

      xml do
        root "format"
        namespace Rfcxml::RfcIndex::Namespace

        map_element "file-format", to: :file_format
      end
    end
  end
end
