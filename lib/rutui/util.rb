module RuTui
	## Ansi Class
	# This Class generates ansi strings for the
	# Terminal based output.
	#
	# Its only tested on Linux, should work atleast
	# on other unix based systems (Use a proper ansi,
	# shell/simulator on windows, and you'll be fine)
	#
	class Ansi
		# Calculate color from RGB values
		def self.rgb(red, green, blue);	16 + (red * 36) + (green * 6) + blue; end
		# Set background color
		def self.bg color; "#{$escape}[48;5;#{color}m"; end
		# Set text color
		def self.fg color; "#{$escape}[38;5;#{color}m"; end
		# "Shortcut" to background color
		def self.background color; self.bg color; end
		# "Shortcut" to foreground/text color
		def self.foreground color; self.fg color; end
		# Set bold
		def self.bold text; "#{$escape}[1m#{text}"; end
		# Set thin
		def self.thin text; "#{$escape}[2m#{text}"; end
		# Set italic
		def self.italic text; "#{$escape}[3m#{text}"; end
		# Set underline
		def self.underline text; "#{$escape}[4m#{text}"; end
		# Set blink
		def self.blink text; "#{$escape}[5m#{text}"; end
		# Clear all color
		def self.clear_color; "#{$escape}[0m"; end
		# Clear Screen/Terminal
		def self.clear; "#{$escape}[2J"; end
		# set start
		def self.set_start; "#{$escape}[s"; end
		# goto start
		def self.goto_start; "#{$escape}[u"; end
		# Go home
		def self.go_home; "#{$escape}[H"; end
		# Goto position
		def self.position x,y; "#{$escape}[#{y};#{x}f"; end
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
			begin
				return [Integer(`tput lines`), Integer(`tput cols`)]
			rescue
				require 'curses'
				Curses.init_screen
				out = [Curses.lines, Curses.cols]
				Curses.close_screen
				return out
			end
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
	end
end
