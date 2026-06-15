# frozen_string_literal: true

require "lutaml/xml"

module Rfcxml
  module RfcIndex
    class Namespace < Lutaml::Xml::W3c::XmlNamespace
      uri "https://www.rfc-editor.org/rfc-index"
      element_form_default :qualified
    end
  end
end
