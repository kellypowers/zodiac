require_relative './lib/version'

Gem::Specification.new do |spec|
  spec.name          = "zodiac_sign"
  spec.version       = ZodiacSign::VERSION
  spec.authors       = ["kellypowers"]
  spec.email         = ["kpowers.nj@gmail.com"]

  spec.summary       = %q{A gem to find out your zodiac sign and the characteristics for zodiac signs}
  #spec.description   = %q{TODO: Write a longer description or delete this line.}
  spec.homepage      = "https://github.com/kellypowers/zodiac"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  #spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/kellypowers/zodiac"
  spec.metadata["changelog_uri"] = "https://github.com/kellypowers/zodiac"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = %w(zodiac_sign.gemspec) + Dir["*.md", "config/*.rb" "bin/*", "lib/*.rb", "config/*.rb"]
  #spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
   # `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  #end
  spec.bindir        = ["bin"]
  spec.executables   = ["zodiac_sign"]
  spec.require_paths = ["lib"]
end
