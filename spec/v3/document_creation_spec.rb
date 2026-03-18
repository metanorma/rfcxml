# frozen_string_literal: true

require "spec_helper"

RSpec.describe "RFC XML Document Creation" do
  # ============================================================================
  # Internet-Draft Example
  # ============================================================================
  #
  # Internet-Drafts are working documents that:
  # - Have a docName (e.g., "draft-ietf-wg-topic-01")
  # - Do NOT have a number (that's assigned when published as RFC)
  # - May have an expiresDate
  # - Use submissionType to indicate the stream (IETF, IAB, IRTF, independent)
  #
  describe "Internet-Draft creation" do
    let(:internet_draft) do
      Rfcxml::V3::Rfc.new(
        # Internet-Draft specific attributes
        doc_name: "draft-ietf-example-protocol-01",
        submission_type: "IETF",
        expires_date: "2025-06-01",

        # Common attributes
        ipr: "trust200902",
        category: "std",
        consensus: "true",
        version: "3",

        # Front matter
        front: Rfcxml::V3::Front.new(
          title: Rfcxml::V3::Title.new(
            content: "Example Protocol for Testing",
            abbrev: "Example Protocol"
          ),
          author: [
            Rfcxml::V3::Author.new(
              fullname: "Jane Doe",
              initials: "J.",
              surname: "Doe",
              role: "editor",
              organization: Rfcxml::V3::Organization.new(content: "Example Corp"),
              address: Rfcxml::V3::Address.new(
                email: Rfcxml::V3::Email.new(content: "jane@example.com")
              )
            )
          ],
          date: Rfcxml::V3::Date.new(
            year: "2025",
            month: "January"
          ),
          keyword: [
            Rfcxml::V3::Keyword.new(content: "protocol"),
            Rfcxml::V3::Keyword.new(content: "testing")
          ],
          abstract: Rfcxml::V3::Abstract.new(
            t: [
              Rfcxml::V3::Text.new(
                content: "This document describes an example protocol for testing purposes."
              )
            ]
          )
        ),

        # Middle section with content
        middle: Rfcxml::V3::Middle.new(
          section: [
            Rfcxml::V3::Section.new(
              anchor: "introduction",
              name: Rfcxml::V3::Name.new(content: "Introduction"),
              t: [
                Rfcxml::V3::Text.new(
                  content: "This is an example Internet-Draft for demonstration purposes."
                ),
                Rfcxml::V3::Text.new(
                  content: "Internet-Drafts are working documents of the IETF."
                )
              ]
            ),
            Rfcxml::V3::Section.new(
              anchor: "requirements",
              name: Rfcxml::V3::Name.new(content: "Requirements"),
              t: [
                Rfcxml::V3::Text.new(
                  content: "The key words MUST, MUST NOT, REQUIRED, etc. are to be interpreted as described in RFC 2119."
                )
              ]
            )
          ]
        ),

        # Back section with references
        back: Rfcxml::V3::Back.new(
          references: [
            Rfcxml::V3::References.new(
              anchor: "normative",
              name: Rfcxml::V3::Name.new(content: "Normative References"),
              reference: [
                Rfcxml::V3::Reference.new(
                  anchor: "RFC2119",
                  front: Rfcxml::V3::Front.new(
                    title: Rfcxml::V3::Title.new(content: "Key words for use in RFCs to Indicate Requirement Levels"),
                    author: [
                      Rfcxml::V3::Author.new(
                        fullname: "S. Bradner",
                        surname: "Bradner"
                      )
                    ],
                    date: Rfcxml::V3::Date.new(year: "1997", month: "March"),
                    series_info: [
                      Rfcxml::V3::SeriesInfo.new(name: "RFC", value: "2119")
                    ]
                  )
                )
              ]
            )
          ]
        )
      )
    end

    it "creates a valid Internet-Draft with docName" do
      expect(internet_draft.doc_name).to eq("draft-ietf-example-protocol-01")
      expect(internet_draft.number).to be_nil
      expect(internet_draft.submission_type).to eq("IETF")
      expect(internet_draft.expires_date).to eq("2025-06-01")
    end

    it "serializes Internet-Draft to valid XML" do
      xml = internet_draft.to_xml(pretty: true, declaration: true, encoding: "utf-8")

      # Verify XML structure
      expect(xml).to include('<?xml version="1.0" encoding="utf-8"?>')
      expect(xml).to include('docName="draft-ietf-example-protocol-01"')
      expect(xml).to include('submissionType="IETF"')
      expect(xml).to include('expiresDate="2025-06-01"')
      expect(xml).to include("<title abbrev=\"Example Protocol\">Example Protocol for Testing</title>")
      expect(xml).to include("fullname=\"Jane Doe\"")
      expect(xml).to include("<abstract>")
      expect(xml).to include("<section anchor=\"introduction\">")
      expect(xml).to include("<references anchor=\"normative\">")
    end

    it "round-trips Internet-Draft preserving structure" do
      xml = internet_draft.to_xml(pretty: true, declaration: true, encoding: "utf-8")

      # Re-parse
      reparsed = Rfcxml::V3::Rfc.from_xml(xml)

      expect(reparsed.doc_name).to eq("draft-ietf-example-protocol-01")
      expect(reparsed.number).to be_nil
      expect(reparsed.submission_type).to eq("IETF")
      expect(reparsed.front.title.content).to eq("Example Protocol for Testing")
      expect(reparsed.front.author.first.fullname).to eq("Jane Doe")
      expect(reparsed.middle.section.count).to eq(2)
    end
  end

  # ============================================================================
  # Published RFC Example
  # ============================================================================
  #
  # Published RFCs:
  # - Have a number (e.g., "8650")
  # - May have obsoletes (comma-separated RFC numbers this replaces)
  # - May have updates (comma-separated RFC numbers this modifies)
  # - Have a category (std, bcp, info, exp, historic)
  # - Do NOT typically have docName in the final version
  # - Do NOT have expiresDate
  #
  describe "Published RFC creation" do
    let(:published_rfc) do
      Rfcxml::V3::Rfc.new(
        # RFC-specific attributes
        number: "9999",
        category: "std",
        obsoletes: "9998",
        updates: "9997,9996",
        consensus: "true",

        # Common attributes
        ipr: "trust200902",
        submission_type: "IETF",
        version: "3",
        scripts: "Common,Latin",
        lang: "en",

        # Front matter
        front: Rfcxml::V3::Front.new(
          title: Rfcxml::V3::Title.new(
            content: "A Standard Protocol for Example Purposes",
            abbrev: "Example Standard"
          ),
          series_info: [
            Rfcxml::V3::SeriesInfo.new(
              name: "RFC",
              value: "9999",
              stream: "IETF"
            )
          ],
          author: [
            Rfcxml::V3::Author.new(
              fullname: "John Smith",
              initials: "J.",
              surname: "Smith",
              organization: Rfcxml::V3::Organization.new(content: "Standards Org"),
              address: Rfcxml::V3::Address.new(
                email: Rfcxml::V3::Email.new(content: "john@standards.org")
              )
            ),
            Rfcxml::V3::Author.new(
              fullname: "Alice Jones",
              initials: "A.",
              surname: "Jones",
              organization: Rfcxml::V3::Organization.new(content: "Tech Company"),
              address: Rfcxml::V3::Address.new(
                email: Rfcxml::V3::Email.new(content: "alice@tech.com")
              )
            )
          ],
          date: Rfcxml::V3::Date.new(
            year: "2025",
            month: "March"
          ),
          area: [
            Rfcxml::V3::Area.new(content: "Applications")
          ],
          workgroup: [
            Rfcxml::V3::Workgroup.new(content: "Example Working Group")
          ],
          keyword: [
            Rfcxml::V3::Keyword.new(content: "standard"),
            Rfcxml::V3::Keyword.new(content: "protocol"),
            Rfcxml::V3::Keyword.new(content: "example")
          ],
          abstract: Rfcxml::V3::Abstract.new(
            t: [
              Rfcxml::V3::Text.new(
                content: "This document specifies a standard protocol for example purposes. " \
                         "It obsoletes RFC 9998 and updates RFC 9997 and RFC 9996."
              )
            ]
          )
        ),

        # Middle section
        middle: Rfcxml::V3::Middle.new(
          section: [
            Rfcxml::V3::Section.new(
              anchor: "overview",
              numbered: "true",
              name: Rfcxml::V3::Name.new(content: "Overview"),
              t: [
                Rfcxml::V3::Text.new(
                  content: "This document defines a standard protocol."
                )
              ]
            ),
            Rfcxml::V3::Section.new(
              anchor: "protocol",
              numbered: "true",
              name: Rfcxml::V3::Name.new(content: "Protocol Definition"),
              t: [
                Rfcxml::V3::Text.new(
                  content: "The protocol operates as follows..."
                )
              ],
              section: [
                Rfcxml::V3::Section.new(
                  anchor: "protocol-messages",
                  numbered: "true",
                  name: Rfcxml::V3::Name.new(content: "Messages"),
                  t: [
                    Rfcxml::V3::Text.new(
                      content: "All messages MUST be formatted as specified."
                    )
                  ]
                )
              ]
            )
          ]
        ),

        # Back section
        back: Rfcxml::V3::Back.new(
          references: [
            Rfcxml::V3::References.new(
              anchor: "normative-references",
              name: Rfcxml::V3::Name.new(content: "Normative References"),
              reference: [
                Rfcxml::V3::Reference.new(
                  anchor: "RFC2119",
                  front: Rfcxml::V3::Front.new(
                    title: Rfcxml::V3::Title.new(
                      content: "Key words for use in RFCs to Indicate Requirement Levels"
                    ),
                    author: [
                      Rfcxml::V3::Author.new(fullname: "S. Bradner", surname: "Bradner")
                    ],
                    date: Rfcxml::V3::Date.new(year: "1997", month: "March"),
                    series_info: [
                      Rfcxml::V3::SeriesInfo.new(name: "RFC", value: "2119")
                    ]
                  )
                )
              ]
            ),
            Rfcxml::V3::References.new(
              anchor: "informative-references",
              name: Rfcxml::V3::Name.new(content: "Informative References"),
              reference: [
                Rfcxml::V3::Reference.new(
                  anchor: "RFC9997",
                  front: Rfcxml::V3::Front.new(
                    title: Rfcxml::V3::Title.new(content: "Previous Related Work"),
                    author: [
                      Rfcxml::V3::Author.new(fullname: "A. Author")
                    ],
                    date: Rfcxml::V3::Date.new(year: "2020"),
                    series_info: [
                      Rfcxml::V3::SeriesInfo.new(name: "RFC", value: "9997")
                    ]
                  )
                )
              ]
            )
          ]
        )
      )
    end

    it "creates a valid RFC with number" do
      expect(published_rfc.number).to eq("9999")
      expect(published_rfc.category).to eq("std")
      expect(published_rfc.obsoletes).to eq("9998")
      expect(published_rfc.updates).to eq("9997,9996")
      expect(published_rfc.consensus).to eq("true")
    end

    it "serializes RFC to valid XML" do
      xml = published_rfc.to_xml(pretty: true, declaration: true, encoding: "utf-8")

      # Verify XML structure
      expect(xml).to include('<?xml version="1.0" encoding="utf-8"?>')
      expect(xml).to include('number="9999"')
      expect(xml).to include('category="std"')
      expect(xml).to include('obsoletes="9998"')
      expect(xml).to include('updates="9997,9996"')
      expect(xml).to include("<title abbrev=\"Example Standard\">A Standard Protocol for Example Purposes</title>")
      expect(xml).to include("<seriesInfo")
      expect(xml).to include('name="RFC"')
      expect(xml).to include('value="9999"')
    end

    it "round-trips RFC preserving structure" do
      xml = published_rfc.to_xml(pretty: true, declaration: true, encoding: "utf-8")

      # Re-parse
      reparsed = Rfcxml::V3::Rfc.from_xml(xml)

      expect(reparsed.number).to eq("9999")
      expect(reparsed.category).to eq("std")
      expect(reparsed.obsoletes).to eq("9998")
      expect(reparsed.updates).to eq("9997,9996")
      expect(reparsed.front.title.content).to eq("A Standard Protocol for Example Purposes")
      expect(reparsed.front.author.count).to eq(2)
      expect(reparsed.middle.section.count).to eq(2)
    end
  end

  # ============================================================================
  # Canon Gem Verification
  # ============================================================================
  #
  # The Canon gem provides semantic XML comparison for round-trip verification
  #
  describe "Canon gem round-trip verification" do
    it "verifies Internet-Draft round-trip with Canon" do
      draft = Rfcxml::V3::Rfc.new(
        doc_name: "draft-test-verification-00",
        submission_type: "IETF",
        ipr: "trust200902",
        version: "3",
        front: Rfcxml::V3::Front.new(
          title: Rfcxml::V3::Title.new(content: "Test Document"),
          author: [
            Rfcxml::V3::Author.new(fullname: "Test Author")
          ],
          date: Rfcxml::V3::Date.new(year: "2025")
        ),
        middle: Rfcxml::V3::Middle.new(
          section: [
            Rfcxml::V3::Section.new(
              name: Rfcxml::V3::Name.new(content: "Test Section"),
              t: [
                Rfcxml::V3::Text.new(content: "Test content.")
              ]
            )
          ]
        )
      )

      # Serialize
      xml_out = draft.to_xml(pretty: true, declaration: true, encoding: "utf-8")

      # Re-parse
      reparsed = Rfcxml::V3::Rfc.from_xml(xml_out)

      # Serialize again
      xml_round_trip = reparsed.to_xml(pretty: true, declaration: true, encoding: "utf-8")

      # Use Canon to verify semantic equivalence
      expect(xml_round_trip).to be_xml_equivalent_to(xml_out)
        .with_profile(:spec_friendly)
    end

    it "verifies RFC round-trip with Canon" do
      rfc = Rfcxml::V3::Rfc.new(
        number: "9999",
        category: "info",
        ipr: "trust200902",
        version: "3",
        front: Rfcxml::V3::Front.new(
          title: Rfcxml::V3::Title.new(content: "Informational RFC"),
          author: [
            Rfcxml::V3::Author.new(fullname: "RFC Author")
          ],
          date: Rfcxml::V3::Date.new(year: "2025")
        ),
        middle: Rfcxml::V3::Middle.new(
          section: [
            Rfcxml::V3::Section.new(
              name: Rfcxml::V3::Name.new(content: "Overview"),
              t: [
                Rfcxml::V3::Text.new(content: "This is an informational RFC.")
              ]
            )
          ]
        )
      )

      # Serialize
      xml_out = rfc.to_xml(pretty: true, declaration: true, encoding: "utf-8")

      # Re-parse
      reparsed = Rfcxml::V3::Rfc.from_xml(xml_out)

      # Serialize again
      xml_round_trip = reparsed.to_xml(pretty: true, declaration: true, encoding: "utf-8")

      # Use Canon to verify semantic equivalence
      expect(xml_round_trip).to be_xml_equivalent_to(xml_out)
        .with_profile(:spec_friendly)
    end
  end

  # ============================================================================
  # Key Differences Summary
  # ============================================================================
  #
  # | Attribute        | Internet-Draft              | Published RFC           |
  # |------------------|----------------------------|-------------------------|
  # | doc_name         | Required (e.g., draft-...) | Optional/Not used       |
  # | number           | Not used                   | Required (e.g., "8650") |
  # | expires_date     | Optional                   | Not used                |
  # | obsoletes        | Not used                   | Optional                |
  # | updates          | Not used                   | Optional                |
  # | category         | Optional                   | Usually present         |
  # | series_info      | Optional                   | Usually present         |
  #
end
