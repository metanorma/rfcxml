# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

**rfcxml** is a Ruby gem for parsing and generating IETF RFC XML v3 documents. It is part of the Metanorma ecosystem and provides bidirectional XML serialization using the lutaml-model framework.

## Development Commands

```bash
# Install dependencies
bundle install

# Run all checks (tests + linting)
bundle exec rake

# Run tests only
bundle exec rake spec
bundle exec rspec                  # Run specific test file
bundle exec rspec spec/v3/rfc_spec.rb

# Run linting only
bundle exec rake rubocop
bundle exec rubocop --autocorrect  # Auto-fix violations

# Interactive development console
bin/console
```

## Architecture

### Core Framework: lutaml-model

All XML elements are modeled as classes inheriting from `Lutaml::Model::Serializable`. This provides ActiveRecord-like serialization for XML with a declarative DSL:

```ruby
class SomeElement < Lutaml::Model::Serializable
  attribute :name, :string
  attribute :child, ChildClass, collection: true

  xml do
    element "element-name"
    map_attribute "name", to: :name
    map_element "child", to: :child
  end
end
```

### Module Structure

- `Rfcxml::V3` namespace contains all RFC XML v3 element models
- Each XML element has its own file in `lib/rfcxml/v3/`
- Models require their dependencies directly (e.g., `Rfc` requires `Front`, `Middle`, `Back`)

### Document Hierarchy

```
Rfc (root)
├── Front (metadata: title, authors, date, abstract)
├── Middle (body: sections)
└── Back (references, appendices)
```

### Mixed Content

Some elements like `Section` support mixed content (text interspersed with child elements). Use `mixed: true` in the root declaration:

```ruby
xml do
  element "section", mixed: true
end
```

## Reference Schema

The `reference-docs/` directory contains the official RFC XML v3 schema files:
- `v3.rnc` - RelaxNG compact syntax (authoritative)
- `v3.xsd` - XML Schema Definition

## Testing

Tests perform round-trip parsing: parse XML → serialize back → verify valid XML structure using the `canon` gem for semantic comparison.
