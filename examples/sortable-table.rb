#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'rutui'

screen = RuTui::Screen.new
@table = RuTui::Table.new({
	:x => 1,
	:y  => 1,
	:highlight_direction => :horizontal, # default
	:table => [
		[1,"Some", "random","example"],
		[2,"text", "presented", "in"],
		[3,"an", "table","plus some random way to long text"]
	],
	:cols => [
		{ :title => "ID", 	 :color => RuTui::Pixel.random.fg, :title_color => RuTui::Pixel.random.fg, :length => 3 },
		{ :title => "Col 1", :color => RuTui::Pixel.random.fg, :title_color => RuTui::Pixel.random.fg },
		{ :title => "Col 2", :color => RuTui::Pixel.random.fg, :title_color => RuTui::Pixel.random.fg },
		{ :title => "Col 3", :color => RuTui::Pixel.random.fg, :title_color => RuTui::Pixel.random.fg, :max_length => 10 }
	],
	:header => true,
	:hover => 32,
	:background => 30
})
screen.add @table
screen.add_static RuTui::Text.new( :x => 1, :y => 9, :text => "Selection: cursor keys, Sort by col: x, Exit: q or CTRL+C" )

highlight = 0
highlight2 = 0

RuTui::ScreenManager.add :default, screen
RuTui::ScreenManager.loop({ :autodraw => true }) do |key|
	break if key == "q" or key == :ctrl_c # CTRL+C

	(highlight += 1; @table.highlight_direction = :horizontal; @table.highlight highlight) if key == :down and highlight < @table.height-1
	(highlight -= 1; @table.highlight_direction = :horizontal; @table.highlight highlight) if key == :up and highlight >= 1
	(highlight2 += 1; @table.highlight_direction = :vertical;  @table.highlight highlight2) if key == :right and highlight2 < @table.width-1
	(highlight2 -= 1; @table.highlight_direction = :vertical;  @table.highlight highlight2) if key == :left and highlight2 >= 1

	if key == "x"
		@table.sort highlight2
	end

end

print RuTui::Ansi.clear_color + RuTui::Ansi.clear
