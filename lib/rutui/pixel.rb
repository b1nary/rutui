module RuTui
	## Pixel Class
	# Each pixel consinsts of foreground, background and
	# a symbol. What it is, is self explainaring
	#
	# Colors can be numbers between 0 and 255
	# (dunno how windows or OSX handles colors over 16)
	#
	# The Symbol may eats every in Ruby working Ascii Symbol
	#
	class Pixel
		attr_accessor :fg, :bg, :symbol

		def initialize foreground = 15, background = nil, symbol = " "
				@fg = foreground
				@bg = background
				@symbol = symbol
		end

		def self.random sym = "#"
			Pixel.new(rand(255),rand(255),sym)
		end
	end
end
