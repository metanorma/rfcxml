# frozen_string_literal: true

require "lutaml/model"

require_relative "cref"
require_relative "eref"
require_relative "iref"
require_relative "xref"

module Rfcxml
  module V3
    class Ttcol < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :width, :string
      attribute :align, :string, default: -> { "left" }
      attribute :cref, Cref, collection: true
      attribute :eref, Eref, collection: true
      attribute :iref, Iref, collection: true
      attribute :xref, Xref, collection: true

      xml do
        root "ttcol"

        map_content to: :content
        map_attribute "width", to: :width
        map_attribute "align", to: :align
        map_element "cref", to: :cref
        map_element "eref", to: :eref
        map_element "iref", to: :iref
        map_element "xref", to: :xref
      end
    end
  end
end
