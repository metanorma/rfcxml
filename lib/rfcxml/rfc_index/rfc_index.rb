# frozen_string_literal: true

require "lutaml/model"

require_relative "namespace"
require_relative "bcp_entry"
require_relative "fyi_entry"
require_relative "rfc_entry"
require_relative "rfc_not_issued_entry"
require_relative "std_entry"

module Rfcxml
  module RfcIndex
    class RfcIndex < Lutaml::Model::Serializable
      attribute :title, :string
      attribute :bcp_entry, BcpEntry, collection: true
      attribute :fyi_entry, FyiEntry, collection: true
      attribute :rfc_entry, RfcEntry, collection: true
      attribute :rfc_not_issued_entry, RfcNotIssuedEntry, collection: true
      attribute :std_entry, StdEntry, collection: true

      xml do
        root "rfc-index"
        namespace Rfcxml::RfcIndex::Namespace
        ordered

        map_attribute "title", to: :title

        map_element "bcp-entry", to: :bcp_entry
        map_element "fyi-entry", to: :fyi_entry
        map_element "rfc-entry", to: :rfc_entry
        map_element "rfc-not-issued-entry", to: :rfc_not_issued_entry
        map_element "std-entry", to: :std_entry
      end
    end
  end
end
