#
# Hello world deeper example for RuTui
#
require 'rubygems'
require 'rutui'

# Create Screen
# You should remember this from the first hallo world
screen = RuTui::Screen.new

# Lets get the shells size
size = RuTui::Utils.winsize

# Lets create a box again, this time stick it to the middle
box = RuTui::Box.new({ :x => size[1]/2-13, :y => 4, :width => 26, :height => 5 })

# add it static
screen.add_static box

# Now lets create an text element into the box!
text = RuTui::Text.new( :x => size[1]/2-11, :y => 6, :text => "You klicked: nil (nil)", :foreground => 14 )

# add the text as dynamic object
screen.add text

# Create loop
# it will automatically redraw after each key input
RuTui::ScreenManager.loop({ :autodraw => true }) do |key|

	break if key == 3 or key.chr == "q" # Exit on STRG+C or "q"

	text.set_text "You klicked: #{key.chr} (#{key})"

end


# this was the a little deeper hello world example ;)
