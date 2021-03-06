# frozen_string_literal: true

require_relative "lib/smiten/version"

Gem::Specification.new do |spec|
  spec.name          = "smiten"
  spec.version       = Smiten::VERSION
  spec.authors       = ["pikelly"]
  spec.email         = ["paul.ian.kelly@gmail.com"]

  spec.summary       = "Connects to hirez smite and paladins apis"
  spec.description   = "Connects to hirez smite and paladins apis"
  spec.homepage      = "https://github.com/pikelly/smiten"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = spec.homepage + "/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features|.creds)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 1.4"
  spec.add_dependency "faraday_middleware", "~> 1.0"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rubocop", "~> 0.80"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "yaml"


  # For more information and examples about making a new gem, checkout our
  # guide at: https://bundler.io/guides/creating_gem.html
end
