require '../rutui.rb'

radius = ARGV[0].to_i
radius = 6 if radius.nil?

screen = RuTui::Screen.new RuTui::Pixel.new(nil,nil," ")
screen.add RuTui::Circle.new({ :x => 2, :y => 2, :radius => radius, :pixel => RuTui::Pixel.new(42,230,"%") })
screen.draw
