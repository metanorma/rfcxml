# frozen_string_literal: true

require "lutaml/model"

require_relative "cref"
require_relative "eref"
require_relative "iref"
require_relative "spanx"
require_relative "xref"

module Rfcxml
  module V3
    class C < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :cref, Cref, collection: true
      attribute :eref, Eref, collection: true
      attribute :iref, Iref, collection: true
      attribute :spanx, Spanx, collection: true
      attribute :xref, Xref, collection: true

      xml do
        root "c"

        map_content to: :content
        map_element "cref", to: :cref
        map_element "eref", to: :eref
        map_element "iref", to: :iref
        map_element "spanx", to: :spanx
        map_element "xref", to: :xref
      end
    end
  end
end
