# frozen_string_literal: true

require "lutaml/model"
require "lutaml/xml"

Lutaml::Model::Config.configure do |config|
  config.xml_adapter_type = :nokogiri
end

module Rfcxml
  class Error < StandardError; end

  autoload :Version, "#{__dir__}/rfcxml/version"
end

require_relative "rfcxml/v3"
require_relative "rfcxml/rfc_index"
