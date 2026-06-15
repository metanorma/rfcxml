# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module RfcIndex
    class Author < Lutaml::Model::Serializable
      attribute :name, :string
      attribute :title, :string
      attribute :organization, :string
      attribute :org_abbrev, :string

      xml do
        root "author"
        namespace Rfcxml::RfcIndex::Namespace

        map_element "name", to: :name
        map_element "title", to: :title
        map_element "organization", to: :organization
        map_element "org-abbrev", to: :org_abbrev
      end
    end
  end
end
