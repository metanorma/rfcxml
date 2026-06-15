# frozen_string_literal: true

module Rfcxml
  module RfcIndex
    autoload :Namespace, "#{__dir__}/rfc_index/namespace"
    autoload :RfcIndex, "#{__dir__}/rfc_index/rfc_index"
    autoload :RfcEntry, "#{__dir__}/rfc_index/rfc_entry"
    autoload :StdEntry, "#{__dir__}/rfc_index/std_entry"
    autoload :BcpEntry, "#{__dir__}/rfc_index/bcp_entry"
    autoload :FyiEntry, "#{__dir__}/rfc_index/fyi_entry"
    autoload :RfcNotIssuedEntry, "#{__dir__}/rfc_index/rfc_not_issued_entry"
    autoload :Author, "#{__dir__}/rfc_index/author"
    autoload :Date, "#{__dir__}/rfc_index/date"
    autoload :Format, "#{__dir__}/rfc_index/format"
    autoload :Keywords, "#{__dir__}/rfc_index/keywords"
    autoload :Kw, "#{__dir__}/rfc_index/kw"
    autoload :Abstract, "#{__dir__}/rfc_index/abstract"
    autoload :DocumentRef, "#{__dir__}/rfc_index/document_ref"
  end
end
