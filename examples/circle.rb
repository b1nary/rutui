require 'rubygems'
require 'rutui'

screen = RuTui::Screen.new
screen.add RuTui::Circle.new({ :x => 2, :y => 2, :radius => 6, :pixel => RuTui::Pixel.new(42,230,"%") })
screen.draw
