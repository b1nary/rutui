# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rutui'

Gem::Specification.new do |s|
  s.name        = 'rutui'
  s.version     = RuTui::VERSION
  s.authors     = ["Roman Pramberger"]
  s.email       = 'roman@pramberger.ch'

  s.summary     = "RUby Textbased User Interface"
  s.description = "Create Pure Ruby textbased interfaces of all kinds"
  s.homepage    = "https://github.com/b1nary/rutui"
  s.license     = "MIT"

  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.required_ruby_version = '>= 2.0.0'

  s.add_development_dependency "bundler", "~> 1.11"
  s.add_development_dependency "rake", "~> 10.0"
  s.add_development_dependency "minitest", "~> 5.0"
end
