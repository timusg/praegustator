# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'praegustator/version'

Gem::Specification.new do |spec|
  spec.name          = "praegustator"
  spec.version       = Praegustator::VERSION
  spec.authors       = ["timusg"]
  spec.email         = ["timusga@gmail.com"]
  spec.description   = %q{test and validate the chef managed infrastructure}
  spec.summary       = "praegustator-#{Praegustator::VERSION}"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
end
