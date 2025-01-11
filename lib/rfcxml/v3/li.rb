# frozen_string_literal: true

require "lutaml/model"

require_relative "artset"
require_relative "artwork"
require_relative "bcp14"
require_relative "blockquote"
require_relative "br"
require_relative "cref"
require_relative "dl"
require_relative "em"
require_relative "eref"
require_relative "figure"
require_relative "iref"
# require_relative "ol"
require_relative "relref"
require_relative "sourcecode"
require_relative "strong"
require_relative "sub"
require_relative "sup"
require_relative "text"
require_relative "table"
require_relative "tt"
require_relative "u"
# require_relative "ul"
require_relative "xref"

module Rfcxml
  module V3
    class Ul < Lutaml::Model::Serializable; end
    class Ol < Lutaml::Model::Serializable; end

    class Li < Lutaml::Model::Serializable
      attribute :content, :string
      attribute :anchor, :string
      attribute :pn, :string
      attribute :artset, Artset, collection: true
      attribute :artwork, Artwork, collection: true
      attribute :dl, Dl, collection: true
      attribute :figure, Figure, collection: true
      attribute :ol, Ol, collection: true
      attribute :sourcecode, Sourcecode, collection: true
      attribute :t, Text, collection: true
      attribute :table, Table, collection: true
      attribute :ul, Ul, collection: true
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
      attribute :u, U, collection: true
      attribute :xref, Xref, collection: true

      attribute :blockquote, Blockquote, collection: true
      attribute :derived_counter, :string

      xml do
        root "li", mixed: true

        map_content to: :content
        map_attribute "anchor", to: :anchor
        map_attribute "derivedCounter", to: :derived_counter
        map_attribute "pn", to: :pn

        %w[artset artwork blockquote dl figure ol sourcecode t table ul bcp14
           br cref em eref iref relref strong sub sup tt u xref].each do |element|
          map_element element, to: element.to_sym
        end
      end
    end
  end
end
