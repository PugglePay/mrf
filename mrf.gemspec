lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mrf/version'

Gem::Specification.new do |spec|
  spec.name          = "mrf"
  spec.version       = MrF::VERSION
  spec.summary       = "Rails Application Secrets With GPG"
  spec.description   = "Rails Application Secrets With GPG"
  spec.homepage      = "https://github.com/pugglepay/mrf"
  spec.license       = "MIT"
  spec.email         = ["dev@pugglepay.com"]

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_dependency "gpgme"
  spec.add_dependency "capistrano"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
