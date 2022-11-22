# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'deepopenstruct'

Gem::Specification.new do |spec|
  spec.name          = 'deepopenstruct'
  spec.version       = DeepOpenStruct::VERSION
  spec.authors       = ['Aaron Gough']
  spec.email         = ['aaron@aarongough.com']

  spec.summary       = 'Sexpistol is an easy-to-use S-Expression parser for Ruby. It is fast and has no dependencies.'
  spec.description   = 'DeepOpenStruct is a simple library for creating easy-to-use data structures from complex sets of nested Hashes and Arrays. It is particularly suitable for creating easy-to-use data structures from YAML files, and as such is a useful tool for creating simple reflective API wrappers.'
  spec.homepage      = 'https://github.com/aarongough/deepopenstruct'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.6.0'

  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov', '~> 0.17.1'
end