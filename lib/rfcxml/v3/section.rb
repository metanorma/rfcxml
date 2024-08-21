# frozen_string_literal: true

require "lutaml/model"

require_relative "artset"
require_relative "artwork"
require_relative "aside"
require_relative "author"
require_relative "blockquote"
require_relative "contact"
require_relative "dl"
require_relative "figure"
require_relative "iref"
require_relative "name"
require_relative "ol"
require_relative "sourcecode"
require_relative "text"
require_relative "table"
require_relative "texttable"
require_relative "ul"

module Rfcxml
  module V3
    class Section < Lutaml::Model::Serializable
      attribute :anchor, :string
      attribute :pn, :string
      attribute :title, :string
      attribute :numbered, :string, default: -> { "true" }
      attribute :toc, :string, default: -> { "default" }
      attribute :remove_in_rfc, :string, default: -> { "false" }
      attribute :name, Name
      attribute :artset, Artset, collection: true
      attribute :artwork, Artwork, collection: true
      attribute :aside, Aside, collection: true
      attribute :author, Author, collection: true
      attribute :blockquote, Blockquote, collection: true
      attribute :contact, Contact, collection: true
      attribute :dl, Dl, collection: true
      attribute :figure, Figure, collection: true
      attribute :iref, Iref, collection: true
      attribute :ol, Ol, collection: true
      attribute :sourcecode, Sourcecode, collection: true
      attribute :t, Text, collection: true
      attribute :table, Table, collection: true
      attribute :texttable, Texttable, collection: true
      attribute :ul, Ul, collection: true
      attribute :section, Section, collection: true

      xml do
        root "section"

        map_attribute "anchor", to: :anchor
        map_attribute "pn", to: :pn
        map_attribute "title", to: :title
        map_attribute "numbered", to: :numbered
        map_attribute "toc", to: :toc
        map_attribute "removeInRFC", to: :remove_in_rfc
        map_element "name", to: :name
        map_element "artset", to: :artset
        map_element "artwork", to: :artwork
        map_element "aside", to: :aside
        map_element "author", to: :author
        map_element "blockquote", to: :blockquote
        map_element "contact", to: :contact
        map_element "dl", to: :dl
        map_element "figure", to: :figure
        map_element "iref", to: :iref
        map_element "ol", to: :ol
        map_element "sourcecode", to: :sourcecode
        map_element "t", to: :t
        map_element "table", to: :table
        map_element "texttable", to: :texttable
        map_element "ul", to: :ul
        map_element "section", to: :section
      end
    end
  end
end
