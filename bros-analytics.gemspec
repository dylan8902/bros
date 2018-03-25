# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "bros-analytics"
  spec.version       = '1.0.0'
  spec.authors       = ["Dylan Jones"]
  spec.email         = ["dyl@anjon.es"]
  spec.summary       = %q{Analytics on a Facebook Message group}
  spec.description   = %q{Analytics on a Facebook Message group.}
  spec.homepage      = "https://dyl.anjon.es/bros-analytics"
  spec.license       = "Apache 2.0"

  spec.files         = ['lib/bros_analytics.rb']
  spec.executables   = ['bin/bros-analytics']
  spec.test_files    = ['tests/test_bros_analytics.rb']
  spec.require_paths = ["lib"]
end
