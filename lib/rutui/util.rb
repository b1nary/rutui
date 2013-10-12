#
# If you want to port this to other Systems, this is your file of choice
# Its heavy unix based in here 
#

## Color Class
# This Class generates color strings for the
# Terminal based output.
# 
# Its only tested on Linux, should work atleast
# on other unix based systems
#

class Color
	# Calculate color from RGB values
	def self.rgb(red, green, blue);	16 + (red * 36) + (green * 6) + blue; end
	# Set background color
	def self.bg color; "\x1b[48;5;#{color}m"; end
	# Set text color
	def self.fg color; "\x1b[38;5;#{color}m"; end
	# "Shortcut" to background color
	def self.background color; self.bg color; end
	# "Shortcut" to foreground/text color
	def self.foreground color; self.fg color; end
	# Clear all color
	def self.clear_color; "\x1b[0m"; end
	# Clear Screen/Terminal
	def self.clear; "\e[2J\e[1;1H"; end
end

## Screen Utils Class
# Static Stuff that fits nowhere else
#
class Utils
	# Get Windows size
	def self.winsize
 		# > Ruby 1.9.3
		#require 'io/console'
		#IO.console.winsize
		#rescue LoadError
		# unix only but each ruby
		[Integer(`tput lines`), Integer(`tput cols`)]

		#if !ENV["LINES"].nil?
		#	[ENV["LINES"], ENV["COLUMNS"]]
		#else
		#	[Integer(`tput lines`), Integer(`tput cols`)]
		#end
	end

	# Get input char without enter 
	# UNIX only! 
	def self.gets
		# Win32API.new("crtdll", "_getch", [], "L").Call).chr
		begin
			system("stty raw -echo")
			str = STDIN.getc
		ensure
			system("stty -raw echo")
		end
		return str.ord
	end

	# Hides the cursor
	def self.init
		system("tput civis")
	end

	# Brings the cursor back
	def self.clear
		system("tput cnorm")
	end

end

