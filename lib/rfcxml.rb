# frozen_string_literal: true

require "lutaml/model"

Lutaml::Model::Config.configure do |config|
  require "lutaml/model/xml_adapter/nokogiri_adapter"
  config.xml_adapter = Lutaml::Model::XmlAdapter::NokogiriAdapter
end

module Rfcxml
  class Error < StandardError; end

  # Your code goes here...
end

require_relative "rfcxml/version"
require_relative "rfcxml/v3"
