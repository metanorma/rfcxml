# frozen_string_literal: true

require "lutaml/model"
require_relative "br"
require_relative "sup"

module Rfcxml
  module V3
    class Strong < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :bcp14, Bcp14, collection: true
      attribute :br, Br, collection: true
      attribute :cref, Cref, collection: true
      attribute :em, Em, collection: true
      attribute :eref, Eref, collection: true
      attribute :iref, Iref, collection: true
      attribute :relref, Relref, collection: true
      attribute :sub, Sub, collection: true
      attribute :sup, Sup, collection: true
      attribute :tt, Tt, collection: true
      attribute :xref, Xref, collection: true

      xml do
        root "strong"

        map_content to: :content
        map_element "bcp14", to: :bcp14
        map_element "br", to: :br
        map_element "cref", to: :cref
        map_element "em", to: :em
        map_element "eref", to: :eref
        map_element "iref", to: :iref
        map_element "relref", to: :relref
        map_element "sub", to: :sub
        map_element "sup", to: :sup
        map_element "tt", to: :tt
        map_element "xref", to: :xref
      end
    end

    class Em < Strong; end
  end
end
