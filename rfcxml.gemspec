# frozen_string_literal: true

require_relative "lib/rfcxml/version"

Gem::Specification.new do |spec|
  spec.name = "rfcxml"
  spec.version = Rfcxml::VERSION
  spec.authors = ["Ribose Inc."]
  spec.email = ["open.source@ribose.com'"]

  spec.summary = "IETF RFC XML parser and generator"
  spec.description = "IETF RFC XML parser and generator"
  spec.homepage = "https://github.com/metanorma/rfcxml"
  spec.license = "BSD-2-Clause"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "https://github.com/metanorma/rfcxml/releases"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem
  # that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`
      .split("\x0")
      .reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.required_ruby_version = ">= 2.7.0"

  spec.add_runtime_dependency "lutaml-model"
  spec.add_runtime_dependency "nokogiri"

  spec.add_development_dependency "equivalent-xml"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rubocop"
  spec.add_development_dependency "rubocop-performance"
  spec.add_development_dependency "xml-c14n"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage
end
