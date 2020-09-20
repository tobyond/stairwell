require_relative 'lib/stairwell/version'

Gem::Specification.new do |spec|
  spec.name          = "stairwell"
  spec.version       = Stairwell::VERSION
  spec.authors       = ["tobyond"]

  spec.summary       = %q{stairwell for sql}
  spec.description   = %q{Sanitize and quote raw SQL for rails and any project in ruby}
  spec.homepage      = "https://github.com/tobyond/stairwell"
  spec.license       = "MIT"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  # spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/tobyond/stairwell"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'zeitwerk', '~> 2.4.0'
end
