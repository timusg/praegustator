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
  spec.summary       = %q{DSL to reuse server spec}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_runtime_dependency "net-ssh"
  spec.add_runtime_dependency "rspec", ">= 2.13.0"
  spec.add_runtime_dependency "highline"
  spec.add_runtime_dependency "chef"
  spec.add_runtime_dependency"serverspec"
  spec.add_runtime_dependency"colorize"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.6"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "aruba"
end
