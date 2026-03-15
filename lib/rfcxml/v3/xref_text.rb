# frozen_string_literal: true

require "lutaml/model"

module Rfcxml
  module V3
    # Mixin module for common text formatting elements
    # Included by Xref, Refcontent, and other elements
    module XrefText
      def self.included(base)
        base.class_eval do
          attribute :em, "Rfcxml::V3::Em", collection: true
          attribute :strong, "Rfcxml::V3::Strong", collection: true
          attribute :sub, "Rfcxml::V3::Sub", collection: true
          attribute :sup, "Rfcxml::V3::Sup", collection: true
          attribute :tt, "Rfcxml::V3::Tt", collection: true
        end
      end
    end
  end
end
