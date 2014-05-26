# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'yeeha/core/version'

Gem::Specification.new do |spec|
  spec.name          = "yeeha-core"
  spec.version       = Yeeha::Core::VERSION
  spec.authors       = ["Jason YiZhang Chen"]
  spec.email         = ["a880074@gmail.com"]
  spec.summary       = "The heart of Yeeha"
  spec.homepage      = "https://github.com/yeeha/yeeha-core"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.require_paths = ["lib"]

end
