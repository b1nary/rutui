#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'rutui'

screen = RuTui::Screen.new
@tf1 = RuTui::Textfield.new({ :x => 1, :y => 1, :pixel => RuTui::Pixel.new(12,44,"-"), :focus_pixel => RuTui::Pixel.new(15,64,"-") })
@tf2 = RuTui::Textfield.new({ :x => 1, :y => 4, :password => true })

screen.add @tf1
screen.add @tf2
screen.add_static RuTui::Text.new( :x => 1, :y => 7, :text => "Start writing, change focus with [tab]" )

@focus = 0
@tf1.set_focus

RuTui::ScreenManager.add :default, screen
RuTui::ScreenManager.loop({ :autodraw => true }) do |key|
	break if key.chr == "q" or key == 3 # CTRL+C

	if @focus == 1 and key == 9
		@tf2.take_focus
		@focus = 0
		@tf1.set_focus
	elsif @focus == 0 and key == 9
		@tf1.take_focus
		@focus = 1
		@tf2.set_focus
	end
	@tf1.write key if @tf1.focus
	@tf2.write key if @tf2.focus
end

print RuTui::Ansi.clear_color + RuTui::Ansi.clear
