# frozen_string_literal: true

require "lutaml/model"

require_relative "sub"

module Rfcxml
  module V3
    class Sup < Sub
      xml do
        root "sup"

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
