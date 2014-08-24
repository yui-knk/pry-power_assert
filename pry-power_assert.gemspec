# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pry-power_assert/version'

Gem::Specification.new do |spec|
  spec.name          = "pry-power_assert"
  spec.version       = PryPowerAssert::VERSION
  spec.authors       = ["yui-knk"]
  spec.email         = ["spiketeika@gmail.com"]
  spec.summary       = "Provides power assert support for Pry"
  spec.description   = "Provides power assert support for Pry"
  spec.homepage      = "https://github.com/yui-knk/pry-power_assert"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "power_assert", "0.1.3"
  spec.add_dependency "pry", ">= 0.9.8"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
