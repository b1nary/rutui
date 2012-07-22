require '../rutui.rb'

screen = RuTui::Screen.new
screen.add RuTui::Axx.new({ :x => 2, :y => 2, :file => 'space-invader.axx' })
screen.draw
