#!/usr/bin/env ruby
#
# Hello world example for RuTui
#

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'rutui'

# Create Screen
# the first screen gets automatically the tag :default
# (which is also the default tag) and gets added to the ScreenManager
# anyway, thats not even important for now
screen = RuTui::Screen.new

# Lets create a box!
box = RuTui::Box.new({ :x => 2, :y => 2, :width => 16, :height => 3 })

# This box should be a static object
# We dont change it while using this screen
# so we can write it directly to the map
screen.add_static box

# Now lets create an text element into the box!
text = RuTui::Text.new( :x => 3, :y => 3, :text => "Hello world!", :foreground => 11 )

# Now lets add the text to the screen map
# this time its not static, so we can modify it later
screen.add text

# Lets draw the screen first time
screen.draw

# Lets wait for a key
a = RuTui::Screen.getc

# and change the text of our text box
text.set_text "Yay!"

# and redraw
screen.draw

# Lets wait for a key again
a = RuTui::Screen.getc

# Lets do a little more!
# Each Object which is dynamic, is moveable
text.move(-1,10)
box.move(-1,10) # This wont work because its static
# you can also text.set_position(x,y)

# we can even modify single pixel by default
text.set_pixel(0,0,RuTui::Pixel.new(2,4,"#"))
text.set_pixel(0,1,RuTui::Pixel.new(5,6,"@"))

# Or whats about the colors?
text.bg = 14
text.fg = 12

# and redraw
screen.draw

# this was the very basic hello world example ;)

print RuTui::Ansi.clear_color + RuTui::Ansi.clear
