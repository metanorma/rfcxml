# frozen_string_literal: true

require "lutaml/model"
require_relative "td"

module Rfcxml
  module V3
    class Th < Td
      xml do
        root "th"
      end
    end
  end
end
