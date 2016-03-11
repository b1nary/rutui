module RuTui
	# Ansi Class
	#
	# Ansi offers ansi escapes for the terminal based output.
	#
	# Its only tested on Linux, should work atleast
	# on other unix based systems like OSX. Use a proper ansi,
	# shell/simulator on windows, and you'll be fine.
	#
	module Ansi
		# Calculate color from RGB values
		#
		# @param red [Integer] RGB red value
		# @param green [Integer] RGB green value
		# @param blue [Integer] RGB blue value
		# @return [Integer] ansi color value from RGB
		def self.rgb(red, green, blue)
			16 + (red * 36) + (green * 6) + blue
		end

		# Background color
		#
		# @param [Integer] color
		# @return [String] Ansi escape sequence
		def self.background color; "\e[48;5;#{color}m"; end

		# Text color
		#
		# @param [Integer] color
		# @return [String] Ansi escape sequence
		def self.foreground color; "\e[38;5;#{color}m"; end

		# See #background
		#
		# @param [Integer] color
		# @return [String] Ansi escape sequence
		def self.bg color; self.background color; end

		# See #foreground
		#
		# @param [Integer] color
		# @return [String] Ansi escape sequence
		def self.fg color; self.foreground color; end

		# Bold
		#
		# @return [String] Ansi escape sequence
		def self.bold; "\e[1m"; end

		# Thin
		#
		# @return [String] Ansi escape sequence
		def self.thin; "\e[2m"; end

		# Italic
		#
		# @return [String] Ansi escape sequence
		def self.italic; "\e[3m"; end

		# Underline
		#
		# @return [String] Ansi escape sequence
		def self.underline; "\e[4m"; end

		# Blink
		#
		# @return [String] Ansi escape sequence
		def self.blink; "\e[5m"; end

		# Clear all color
		#
		# @return [String] Ansi escape sequence
		def self.clear_color; "\e[0m"; end

		# Clear Screen/Terminal
		#
		# @return [String] Ansi escape sequence
		def self.clear; "\e[2J"; end

		# Set start position
		#
		# @return [String] Ansi escape sequence
		def self.set_start; "\e[s"; end

		# Goto start position
		#
		# @return [String] Ansi escape sequence
		def self.goto_start; "\e[u"; end

		# Go to home position
		#
		# @return [String] Ansi escape sequence
		def self.go_home; "\e[H"; end

		# Goto position
		#
		# @param x [Integer] x position
		# @param y [Integer] y position
		# @return [String] Ansi escape sequence
		def self.position x,y; "\e[#{y};#{x}f"; end

		# Hide cursor
		#
		# @return [String] Ansi escape sequence
		def self.hide_cursor; "\e?25l"; end
	end
end
