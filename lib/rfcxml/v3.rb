# frozen_string_literal: true

module Rfcxml
  module V3
    # Core document structure
    autoload :Rfc, "#{__dir__}/v3/rfc"
    autoload :Front, "#{__dir__}/v3/front"
    autoload :Middle, "#{__dir__}/v3/middle"
    autoload :Back, "#{__dir__}/v3/back"

    # Front matter elements
    autoload :Abstract, "#{__dir__}/v3/abstract"
    autoload :Annotation, "#{__dir__}/v3/annotation"
    autoload :Area, "#{__dir__}/v3/area"
    autoload :Author, "#{__dir__}/v3/author"
    autoload :Contact, "#{__dir__}/v3/contact"
    autoload :Date, "#{__dir__}/v3/date"
    autoload :Keyword, "#{__dir__}/v3/keyword"
    autoload :Note, "#{__dir__}/v3/note"
    autoload :Organization, "#{__dir__}/v3/organization"
    autoload :Title, "#{__dir__}/v3/title"
    autoload :Workgroup, "#{__dir__}/v3/workgroup"

    # Address elements
    autoload :Address, "#{__dir__}/v3/address"
    autoload :City, "#{__dir__}/v3/city"
    autoload :Cityarea, "#{__dir__}/v3/cityarea"
    autoload :Country, "#{__dir__}/v3/country"
    autoload :Email, "#{__dir__}/v3/email"
    autoload :Extaddr, "#{__dir__}/v3/extaddr"
    autoload :Facsimile, "#{__dir__}/v3/facsimile"
    autoload :Phone, "#{__dir__}/v3/phone"
    autoload :Pobox, "#{__dir__}/v3/pobox"
    autoload :Postal, "#{__dir__}/v3/postal"
    autoload :PostalLine, "#{__dir__}/v3/postal_line"
    autoload :Region, "#{__dir__}/v3/region"
    autoload :Sortingcode, "#{__dir__}/v3/sortingcode"
    autoload :Street, "#{__dir__}/v3/street"
    autoload :Uri, "#{__dir__}/v3/uri"

    # Body elements
    autoload :Section, "#{__dir__}/v3/section"
    autoload :Aside, "#{__dir__}/v3/aside"
    autoload :Blockquote, "#{__dir__}/v3/blockquote"
    autoload :Boilerplate, "#{__dir__}/v3/boilerplate"
    autoload :Figure, "#{__dir__}/v3/figure"
    autoload :Ol, "#{__dir__}/v3/ol"
    autoload :Ul, "#{__dir__}/v3/ul"
    autoload :Li, "#{__dir__}/v3/li"
    autoload :Dl, "#{__dir__}/v3/dl"
    autoload :Dt, "#{__dir__}/v3/dt"
    autoload :Dd, "#{__dir__}/v3/dd"
    autoload :Table, "#{__dir__}/v3/table"
    autoload :Tbody, "#{__dir__}/v3/tbody"
    autoload :Tfoot, "#{__dir__}/v3/tfoot"
    autoload :Thead, "#{__dir__}/v3/thead"
    autoload :Tr, "#{__dir__}/v3/tr"
    autoload :Td, "#{__dir__}/v3/td"
    autoload :Th, "#{__dir__}/v3/th"

    # Inline text elements
    autoload :Bcp14, "#{__dir__}/v3/bcp14"
    autoload :Br, "#{__dir__}/v3/br"
    autoload :C, "#{__dir__}/v3/c"
    autoload :Code, "#{__dir__}/v3/code"
    autoload :Cref, "#{__dir__}/v3/cref"
    autoload :Em, "#{__dir__}/v3/strong" # Em is defined in strong.rb
    autoload :Eref, "#{__dir__}/v3/eref"
    autoload :Iref, "#{__dir__}/v3/iref"
    autoload :Name, "#{__dir__}/v3/name"
    autoload :Postamble, "#{__dir__}/v3/postamble"
    autoload :Preamble, "#{__dir__}/v3/preamble"
    autoload :Relref, "#{__dir__}/v3/relref"
    autoload :Spanx, "#{__dir__}/v3/spanx"
    autoload :Strong, "#{__dir__}/v3/strong"
    autoload :Sub, "#{__dir__}/v3/sub"
    autoload :Sup, "#{__dir__}/v3/sup"
    autoload :Tt, "#{__dir__}/v3/tt"
    autoload :U, "#{__dir__}/v3/u"
    autoload :Xref, "#{__dir__}/v3/xref"
    autoload :XrefText, "#{__dir__}/v3/xref_text"

    # Artwork and code elements
    autoload :Artset, "#{__dir__}/v3/artset"
    autoload :Artwork, "#{__dir__}/v3/artwork"
    autoload :Sourcecode, "#{__dir__}/v3/sourcecode"

    # References
    autoload :Displayreference, "#{__dir__}/v3/displayreference"
    autoload :Refcontent, "#{__dir__}/v3/refcontent"
    autoload :Reference, "#{__dir__}/v3/reference"
    autoload :Referencegroup, "#{__dir__}/v3/referencegroup"
    autoload :References, "#{__dir__}/v3/references"

    # Other elements
    autoload :Format, "#{__dir__}/v3/format"
    autoload :Link, "#{__dir__}/v3/link"
    autoload :List, "#{__dir__}/v3/list"
    autoload :SeriesInfo, "#{__dir__}/v3/series_info"
    autoload :Text, "#{__dir__}/v3/text"
    autoload :Texttable, "#{__dir__}/v3/texttable"
    autoload :Toc, "#{__dir__}/v3/toc"
    autoload :Ttcol, "#{__dir__}/v3/ttcol"
    autoload :Vspace, "#{__dir__}/v3/vspace"
  end
end
