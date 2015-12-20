Gem::Specification.new do |s|
  s.name        = 'rutui'
  s.version     = '0.7.1'
  s.date        = '2014-08-22'
  s.summary     = "RUby Textbased User Interface"
  s.description = "Create Pure Ruby textbased interfaces of all kinds (Unix only)"
  s.license     = "MIT"
  s.authors     = ["Roman Pramberger"]
  s.email       = 'roman@pramberger.ch'
  s.files       = [ "lib/rutui.rb", "lib/rutui/ansi.rb", "lib/rutui/pixel.rb",
                    "lib/rutui/input.rb", "lib/rutui/theme.rb", "lib/rutui/objects.rb",
                    "lib/rutui/screen.rb", "lib/rutui/checkbox.rb",
                    "lib/rutui/screenmanager.rb", "lib/rutui/figlet.rb", "lib/rutui/axx.rb",
                    "lib/rutui/sprites.rb", "lib/rutui/table.rb", "lib/rutui/textfield.rb"]
  s.homepage    = 'http://rubygems.org/gems/rutui'
  s.required_ruby_version = '>= 2.0.0'
end
