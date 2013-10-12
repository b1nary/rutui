require 'rutui'

RuTui::Figlet.add :test_font, "colossal.flf"

screen = RuTui::Screen.new
screen.add_static RuTui::Axx.new({ :x => 3, :y => 2, :file => 'space-invader.axx' })
screen.add_static RuTui::Figlet.new({ :y => 2, :x => 18, :font => :test_font, :text => 'RuTui' })
screen.draw
