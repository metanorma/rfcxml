# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Sub < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :bcp14, Bcp14, collection: true
      attribute :cref, Cref, collection: true
      attribute :em, "Rfcxml::V3::Em", collection: true
      attribute :eref, Eref, collection: true
      attribute :iref, Iref, collection: true
      attribute :relref, Relref, collection: true
      attribute :strong, "Rfcxml::V3::Strong", collection: true
      attribute :sub, Sub, collection: true
      attribute :sup, "Rfcxml::V3::Sup", collection: true
      attribute :tt, "Rfcxml::V3::Tt", collection: true
      attribute :xref, Xref, collection: true

      xml do
        element "sub"
        ordered

        map_content to: :content
        map_element "bcp14", to: :bcp14
        map_element "cref", to: :cref
        map_element "em", to: :em
        map_element "eref", to: :eref
        map_element "iref", to: :iref
        map_element "relref", to: :relref
        map_element "strong", to: :strong
        map_element "sub", to: :sub
        map_element "sup", to: :sup
        map_element "tt", to: :tt
        map_element "xref", to: :xref
      end
    end
  end
end
