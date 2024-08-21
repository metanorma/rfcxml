# frozen_string_literal: true

require "lutaml/model"
require_relative "strong"

module Rfcxml
  module V3
    class Em < Strong
      xml do
        root "em"
      end
    end
  end
end
