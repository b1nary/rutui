#!/usr/bin/env ruby
#
# Hello world deeper example for RuTui
#

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'rutui'

# Switch theme
RuTui::Theme.use :light

# Create Screen
# You should remember this from the first hallo world
screen = RuTui::Screen.new

# Lets get the shells size
size = RuTui::Screen.size

# Lets create a box again, this time stick it to the middle
box = RuTui::Box.new({ :x => size[1]/2-13, :y => 4, :width => 26, :height => 5 })

# add it static
screen.add_static box

# Now lets create an text element into the box!
text = RuTui::Text.new( :x => size[1]/2-11, :y => 6, :text => "You pressed: nil (nil)" )
last = RuTui::Text.new( :x => size[1]/2-2, :y => 12, :text => "Last: nil (nil)")
lost = RuTui::Text.new( :x => size[1]/2-2, :y => 13, :text => "Last: nil (nil)")

# add the text as dynamic object
screen.add text
screen.add last
screen.add lost

# Add some info, may somebody would'nt find out else
info = RuTui::Text.new( :x => 1, :y => 1, :text => "Press any key. Use q or CTRL+C to close" )
screen.add_static info

# Create loop
# it will automatically redraw after each key input
RuTui::ScreenManager.loop({ :autodraw => true }) do |key|
	break if key == :ctrl_c or key == "q" # Exit on STRG+C or "q"
	lost.set_text last.get_text
	last.set_text text.get_text
	key_desc = key.class == Symbol ? key.to_s.sub('_', '+').capitalize : key
	text.set_text "You pressed: #{key_desc} (#{key.ord unless key.class == Symbol})"
end

# this was the a little deeper hello world example ;)
print RuTui::Ansi.clear_color + RuTui::Ansi.clear
