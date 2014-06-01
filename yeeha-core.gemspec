# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yeeha_core/version'

Gem::Specification.new do |spec|
  spec.name          = "yeeha-core"
  spec.version       = YeehaCore::VERSION
  spec.authors       = ["Jason YiZhang Chen"]
  spec.email         = ["a880074@gmail.com"]
  spec.summary       = "The heart of Yeeha"
  spec.homepage      = "https://github.com/yeeha/yeeha-core"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

  spec.add_dependency "nokogiri", '~> 1.6.2.1'
  spec.add_dependency "chunky_png", '~> 1.3.1'
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", '~> 2.14.1'
end
