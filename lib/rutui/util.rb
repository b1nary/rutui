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
		@@escape = "\x1b"
		@@escape = "\033" if RUBY_PLATFORM =~ /(win32|w32)/

		# Calculate color from RGB values
		def self.rgb(red, green, blue);	16 + (red * 36) + (green * 6) + blue; end
		# Set background color
		def self.bg color; "#{@@escape}[48;5;#{color}m"; end
		# Set text color
		def self.fg color; "#{@@escape}[38;5;#{color}m"; end
		# "Shortcut" to background color
		def self.background color; self.bg color; end
		# "Shortcut" to foreground/text color
		def self.foreground color; self.fg color; end
		# Set bold
		def self.bold text; "#{@@escape}[1m#{text}"; end
		# Set thin
		def self.thin text; "#{@@escape}[2m#{text}"; end
		# Set italic
		def self.italic text; "#{@@escape}[3m#{text}"; end
		# Set underline
		def self.underline text; "#{@@escape}[4m#{text}"; end
		# Set blink
		def self.blink text; "#{@@escape}[5m#{text}"; end
		# Clear all color
		def self.clear_color; "#{@@escape}[0m"; end
		# Clear Screen/Terminal
		def self.clear; "#{@@escape}[2J"; end
		# set start
		def self.set_start; "#{@@escape}[s"; end
		# goto start
		def self.goto_start; "#{@@escape}[u"; end
		# Go home
		def self.go_home; "#{@@escape}[H"; end
		# Goto position
		def self.position x,y; "#{@@escape}[#{y};#{x}f"; end
	end
end
