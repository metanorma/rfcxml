# frozen_string_literal: true

require "lutaml/model"

Lutaml::Model::Config.configure do |config|
  require "lutaml/model/xml_adapter/nokogiri_adapter"
  config.xml_adapter = Lutaml::Model::XmlAdapter::NokogiriAdapter
end

module Rfcxml
  class Error < StandardError; end

  autoload :Version, "#{__dir__}/rfcxml/version"
end

require_relative "rfcxml/v3"
