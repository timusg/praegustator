# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'praegustator/version'

Gem::Specification.new do |spec|
  spec.name          = "praegustator"
  spec.version       = Praegustator::VERSION
  spec.authors       = ["timusg"]
  spec.email         = ["timusga@gmail.com"]
  spec.description   = %q{taste and validate the chef cooked infrastructure}
  spec.summary       = %q{DSL over server spec to test chef powered infrastructure}
  spec.homepage      = "https://github.com/timusg/praegustator"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features|feautures_setup|tmp)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_runtime_dependency "rspec", ">= 2.13.0"
  spec.add_runtime_dependency "chef" , ">= 11.4.4"
  spec.add_runtime_dependency "serverspec"
  spec.add_runtime_dependency "colorize"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 2.13.0"
  spec.add_development_dependency "rspec-mocks"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
end
