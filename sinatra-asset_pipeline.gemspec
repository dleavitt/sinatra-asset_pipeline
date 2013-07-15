# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sinatra/asset_pipeline/version'

Gem::Specification.new do |spec|
  spec.name          = "sinatra-asset_pipeline"
  spec.version       = Sinatra::AssetPipeline::VERSION
  spec.authors       = ["Daniel Leavitt"]
  spec.email         = ["daniel.leavitt@gmail.com"]
  spec.description   = %q{Simple sprockets asset server for Sinatra}
  spec.summary       = %q{Simple sprockets asset server for Sinatra}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'sinatra'
  spec.add_dependency 'sprockets'
  spec.add_dependency 'sprockets-helpers'
end
