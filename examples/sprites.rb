require 'rutui'

screen = RuTui::Screen.new

size = RuTui::Utils.winsize

screen.add_static RuTui::Text.new({ :x => size[1]/2-14, :y  => 2, :text => "use WASD or q/CTRL+C to quit" })

sprites = RuTui::Sprite.new({ :x => size[1]/2-6, :y => 5, :file => 'res/space-invader_sprite.axx' })
screen.add sprites

Thread.new {
	while true
		sprites.update
		RuTui::ScreenManager.draw
		sleep 0.8
	end
}

RuTui::ScreenManager.loop({ :autofit => true, :autodraw => false }) do |key|

	break if key == 3 or key.chr == "q"

	sprites.set_current "left"  if key.chr == "a"
	sprites.set_current "right" if key.chr == "d"
	sprites.set_current "up"    if key.chr == "w"
	sprites.set_current "down"  if key.chr == "s"

end

print Ansi.clear_color + Ansi.clear
