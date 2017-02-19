Gem::Specification.new do |s|
  s.name        = 'rutui'
  s.version     = '0.7.2'
  s.summary     = "RUby Textbased User Interface"
  s.description = "Create Pure Ruby textbased interfaces of all kinds (Unix only)"
  s.license     = "MIT"
  s.authors     = ["Roman Pramberger"]
  s.email       = 'roman@pramberger.ch'
  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  s.homepage    = 'http://rubygems.org/gems/rutui'
  s.required_ruby_version = '>= 2.0.0'
end
