#!/usr/bin/env ruby
#
# Tic-Tac-Toe
#
# This is the first example done in this library
# Its more a proof of concept than an read worthy example
#

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'rutui'

RuTui::Theme.use :basic
screen = RuTui::Screen.new

RuTui::ScreenManager.add :default, screen
RuTui::ScreenManager.set_current :default

size = RuTui::Screen.size
map = [[0,0,0],[0,0,0],[0,0,0]]
current = "X"
pos = [0,0]

screen.add_static RuTui::Text.new({
	:x => (size[1]/2)-3,
	:y => 2,
	:text => "Tic-Tac-Toe",
	:foreground => 15 })

screen.add_static RuTui::Text.new({
	:x => (size[1]/2)-2,
	:y => 3,
	:text => "by b1nary",
	:foreground => 244 })

screen.add info = RuTui::Text.new({
	:x => (size[1]/2)-3,
	:y => 12,
	:text => "Current:  #{current}",
	:foreground => 250 })

hor = RuTui::Pixel.new(RuTui::Theme.get(:border).fg, RuTui::Theme.get(:background).bg, "-")
ver = RuTui::Pixel.new(RuTui::Theme.get(:border).fg, RuTui::Theme.get(:background).bg, "|")
cor = RuTui::Pixel.new(RuTui::Theme.get(:border).fg, RuTui::Theme.get(:background).bg, "*")

xhor = RuTui::Pixel.new(RuTui::Theme.get(:textcolor), RuTui::Theme.get(:background).bg, "-")
xver = RuTui::Pixel.new(RuTui::Theme.get(:textcolor), RuTui::Theme.get(:background).bg, "|")
xcor = RuTui::Pixel.new(RuTui::Theme.get(:textcolor), RuTui::Theme.get(:background).bg, "#")

3.times do |ir|
	3.times do |ic|
		screen.add_static RuTui::Box.new({
			:x => (size[1]/2)+(ic*4-4),
			:y => 5+(ir*2),
			:width => 5,
			:height => 3,
			:horizontal => hor,
			:vertical => ver,
			:corner => cor })
	end
end

screen.add box0 = RuTui::Box.new({
	:x => (size[1]/2)-4,
	:y => 5,
	:width => 5,
	:height => 3,
	:horizontal => xhor,
	:vertical => xver,
	:corner => xcor })


RuTui::ScreenManager.loop({ :autodraw => true }) do |key|

	if key == "q" or key == :ctrl_c # CTRL+C
		break

	elsif key == " " # space bar
		if map[pos[0]][pos[1]] == 0
			color = RuTui::Theme.get(:rainbow)[1] if current == "X"
			color = RuTui::Theme.get(:rainbow)[0] if current == "O"

			screen.add RuTui::Text.new({
				:x => (size[1]/2)+(pos[0]*4-4)+2,
				:y => 5+(pos[1]*2)+1,
				:text => current,
				:foreground => color })

			map[pos[0]][pos[1]] = current.dup

			# Simple all possibilities, not that much so ....
			(info.set_text "#{current} WON! yay!"; RuTui::ScreenManager.draw; break) if (map[0][0] == map[0][1] and map[0][0] == map[0][2] and map[0][2]!=0) or (map[1][0] == map[1][1] and map[1][0] == map[1][2] and map[1][2]!=0) or (map[2][0] == map[2][1] and map[2][0] == map[2][2] and map[2][2]!=0) or (map[0][0] == map[1][0] and map[1][0] == map[2][0] and map[2][0]!=0) or (map[0][1] == map[1][1] and map[1][1] == map[2][1] and map[2][1]!=0) or (map[0][2] == map[1][2] and map[1][2] == map[2][2] and map[1][2]!=0) or (map[0][0] == map[1][1] and map[1][1] == map[2][2] and map[1][1]!=0) or (map[2][0] == map[1][1] and map[2][0] == map[0][2] and map[2][0]!=0)

			if current == "X"
				current = "O"
			else
				current = "X"
			end

			info.set_text "Current:  #{current}"
		end

	elsif key == 'w' or key == :up # up
		(box0.move(0,-2); pos[1] -= 1) if pos[1] > 0
	elsif key == 's' or key == :down # down
		(box0.move(0,2); pos[1] += 1) if pos[1] < 2
	elsif key == 'd' or key == :right # right
		(box0.move(4,0); pos[0] += 1) if pos[0] < 2
	elsif key == 'a' or key == :left # left
		(box0.move(-4,0); pos[0] -= 1) if pos[0] > 0
	end
end

print RuTui::Ansi.clear_color + RuTui::Ansi.clear
