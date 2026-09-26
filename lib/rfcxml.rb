# frozen_string_literal: true

require "lutaml/model"
require "lutaml/xml"

# No require-time adapter configuration: assigning xml_adapter_type here
# globally clobbered the host application's adapter selection mid-process
# (e.g. a parse already in flight on a different adapter, lutaml-model
# #871). lutaml-model resolves an adapter on demand when none is pinned.

module Rfcxml
  class Error < StandardError; end

  autoload :Version, "#{__dir__}/rfcxml/version"
end

require_relative "rfcxml/v3"
require_relative "rfcxml/rfc_index"
