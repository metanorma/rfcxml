# frozen_string_literal: true

require "lutaml/model"

require_relative "bcp14"
require_relative "cref"
require_relative "em"
require_relative "eref"
require_relative "iref"
require_relative "relref"
require_relative "spanx"
require_relative "strong"
require_relative "sub"
require_relative "sup"
require_relative "tt"
require_relative "u"
require_relative "xref"

module Rfcxml
  module V3
    class Annotation < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :bcp14, Bcp14, collection: true
      attribute :cref, Cref, collection: true
      attribute :em, Em, collection: true
      attribute :eref, Eref, collection: true
      attribute :iref, Iref, collection: true
      attribute :relref, Relref, collection: true
      attribute :spanx, Spanx, collection: true
      attribute :strong, Strong, collection: true
      attribute :sub, Sub, collection: true
      attribute :sup, Sup, collection: true
      attribute :tt, Tt, collection: true
      attribute :u, U, collection: true
      attribute :xref, Xref, collection: true

      xml do
        root "annotation", mixed: true

        map_content to: :content
        map_element "bcp14", to: :bcp14
        map_element "cref", to: :cref
        map_element "em", to: :em
        map_element "eref", to: :eref
        map_element "iref", to: :iref
        map_element "relref", to: :relref
        map_element "spanx", to: :spanx
        map_element "strong", to: :strong
        map_element "sub", to: :sub
        map_element "sup", to: :sup
        map_element "tt", to: :tt
        map_element "u", to: :u
        map_element "xref", to: :xref
      end
    end
  end
end
