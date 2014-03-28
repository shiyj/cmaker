# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'cmaker/version'

Gem::Specification.new do |spec|
  spec.name          = "cmaker"
  spec.version       = CMaker::VERSION
  spec.authors       = ["shiyj"]
  spec.email         = ["shiyj.cn@gmail.com"]
  spec.description   = %q{This gem generate  source files needed for CMakeLists.txt}
  spec.summary       = %q{This gem generate  source files needed for CMakeLists.txt}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib","bin"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
