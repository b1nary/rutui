#
# Tic-Tac-Toe
#
# This is the first example done in this library
# Its more a proof of concept than an read worthy example
#
require 'rutui'

screen = RuTui::Screen.new
RuTui::ScreenManager.add :default, screen
RuTui::ScreenManager.set_current :default

@size = RuTui::Utils.winsize
@map = [[0,0,0],[0,0,0],[0,0,0]]
@current = "X"
pos = [0,0]

text = RuTui::Text.new({ :x => (@size[1]/2)-3, :y => 2, :text => "Tic-Tac-Toe", :foreground => 15 })
by   = RuTui::Text.new({ :x => (@size[1]/2)-2, :y => 3, :text => "by b1nary", :foreground => 244 })
info = RuTui::Text.new({ :x => (@size[1]/2)-3, :y => 12, :text => "Current:  #{@current}", :foreground => 250 })
screen.add_static text
screen.add_static by
screen.add info

hor = RuTui::Pixel.new(112,236,"-")
ver = RuTui::Pixel.new(112,236,"|")
cor = RuTui::Pixel.new(112,236,"*")

xhor = RuTui::Pixel.new(152,236,"-")
xver = RuTui::Pixel.new(152,236,"|")
xcor = RuTui::Pixel.new(152,236,"#")

3.times do |ir|
	3.times do |ic|
		screen.add_static RuTui::Box.new({ :x => (@size[1]/2)+(ic*4-4), :y => 5+(ir*2), :width => 5, :height => 3, :horizontal => hor, :vertical => ver, :corner => cor })
	end
end

box0 = RuTui::Box.new({ :x => (@size[1]/2)-4, :y => 5, :width => 5, :height => 3, :horizontal => xhor, :vertical => xver, :corner => xcor })
screen.add box0


RuTui::ScreenManager.loop({ :autodraw => true }) do |key|

	#File.open("test", "a"){ |f| f.write("#{key.to_i}\n") }
	if key.chr == "q" or key == 3 # CTRL+C
		break

	elsif key == 13 # enter
		if @map[pos[0]][pos[1]] == 0
			color = 111 if @current == "X"
			color = 227 if @current == "O"

			screen.add RuTui::Text.new({ :x => (@size[1]/2)+(pos[0]*4-4)+2, :y => 5+(pos[1]*2)+1, :text => @current, :foreground => color })
			@map[pos[0]][pos[1]] = @current.dup
			p @map	

			# Simple all possibilities, not that much so ....
			(info.set_text "#{@current} WON! yay!"; RuTui::ScreenManager.draw; break) if (@map[0][0] == @map[0][1] and @map[0][0] == @map[0][2] and @map[0][2]!=0) or (@map[1][0] == @map[1][1] and @map[1][0] == @map[1][2] and @map[1][2]!=0) or (@map[2][0] == @map[2][1] and @map[2][0] == @map[2][2] and @map[2][2]!=0) or (@map[0][0] == @map[1][0] and @map[1][0] == @map[2][0] and @map[2][0]!=0) or (@map[0][1] == @map[1][1] and @map[1][1] == @map[2][1] and @map[2][1]!=0) or (@map[0][2] == @map[1][2] and @map[1][2] == @map[2][2] and @map[1][2]!=0) or (@map[0][0] == @map[1][1] and @map[1][1] == @map[2][2] and @map[1][1]!=0) or (@map[2][0] == @map[1][1] and @map[2][0] == @map[0][2] and @map[2][0]!=0)

			if @current == "X"
				@current = "O"
			else
				@current = "X"
			end

			info.set_text "Current:  #{@current}"
		end

	elsif key.chr == 'w' # up
		(box0.move(0,-2); pos[1] -= 1) if pos[1] > 0
	elsif key.chr == 's' # down
		(box0.move(0,2); pos[1] += 1) if pos[1] < 2
	elsif key.chr == 'd' # right
		(box0.move(4,0); pos[0] += 1) if pos[0] < 2
	elsif key.chr == 'a' # left
		(box0.move(-4,0); pos[0] -= 1) if pos[0] > 0
	end
end

RuTui::Utils.clear
