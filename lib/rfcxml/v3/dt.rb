# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    class Dt < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :pn, :string
      attribute :bcp14, Bcp14, collection: true
      attribute :br, Br, collection: true
      attribute :cref, Cref, collection: true
      attribute :em, Em, collection: true
      attribute :eref, Eref, collection: true
      attribute :iref, Iref, collection: true
      attribute :relref, Relref, collection: true
      attribute :strong, Strong, collection: true
      attribute :sub, Sub, collection: true
      attribute :sup, Sup, collection: true
      attribute :tt, Tt, collection: true
      attribute :xref, Xref, collection: true

      xml do
        element "dt"
        ordered

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn

        %w[bcp14 br cref em eref iref relref strong sub sup tt
           xref].each do |element|
          map_element element, to: element.to_sym
        end
      end
    end
  end
end
