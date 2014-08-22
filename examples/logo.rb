require 'rutui'

RuTui::Figlet.add :test_font, "res/colossal.flf"

screen = RuTui::Screen.new
screen.add_static RuTui::Axx.new({ :x => 3, :y => 2, :file => 'res/space-invader.axx' })
screen.add_static RuTui::Figlet.new({ :y => 2, :x => 18, :font => :test_font, :text => 'RuTui' })
screen.draw

print Ansi.clear_color + Ansi.clear