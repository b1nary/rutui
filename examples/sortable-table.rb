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
		{ :title => "ID", 	 :color => Pixel.random.fg, :title_color => Pixel.random.fg, :length => 3 },
		{ :title => "Col 1", :color => Pixel.random.fg, :title_color => Pixel.random.fg },
		{ :title => "Col 2", :color => Pixel.random.fg, :title_color => Pixel.random.fg },
		{ :title => "Col 3", :color => Pixel.random.fg, :title_color => Pixel.random.fg, :max_length => 10 }
	],
	:header => true,
	:hover => 32,
	:background => 30
})
screen.add @table
screen.add_static RuTui::Text.new( :x => 1, :y => 8, :text => "Selection: w a s d, Sort by col: x" )

highlight = 0
highlight2 = 0

RuTui::ScreenManager.add :default, screen
RuTui::ScreenManager.loop({ :autodraw => true }) do |key|
	break if key.chr == "q" or key == 3 # CTRL+C

	(highlight += 1; @table.highlight_direction = :horizontal; @table.highlight highlight) if key.chr == "s" and highlight < @table.height-1
	(highlight -= 1; @table.highlight_direction = :horizontal; @table.highlight highlight) if key.chr == "w" and highlight >= 1
	(highlight2 += 1; @table.highlight_direction = :vertical;  @table.highlight highlight2) if key.chr == "d" and highlight2 < @table.width-1
	(highlight2 -= 1; @table.highlight_direction = :vertical;  @table.highlight highlight2) if key.chr == "a" and highlight2 >= 1

	if key.chr == "x"
		@table.sort highlight2
	end

end

print Ansi.clear_color + Ansi.clear
