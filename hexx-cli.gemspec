$:.push File.expand_path("../lib", __FILE__)
require "hexx/cli/version"

Gem::Specification.new do |gem|

  gem.name        = "hexx-cli"
  gem.version     = Hexx::CLI::VERSION.dup
  gem.author      = "Andrew Kozin"
  gem.email       = "andrew.kozin@gmail.com"
  gem.homepage    = "https://github.com/nepalez/hexx-cli"
  gem.description = "Base generator."
  gem.summary     = "Extends the Thor::Group generator with additional helpers."
  gem.license     = "MIT"
  gem.platform    = Gem::Platform::RUBY

  gem.require_paths    = ["lib"]
  gem.files            = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  gem.test_files       = Dir["spec/**/*.rb"]
  gem.extra_rdoc_files = Dir["README.md", "LICENSE"]

  gem.required_ruby_version = "~> 2.0"
  gem.add_runtime_dependency "extlib", "~> 0.9"
  gem.add_runtime_dependency "thor", "~> 0.19"
  gem.add_development_dependency "hexx-rspec", "~> 0.3"

end # Gem::Specification
