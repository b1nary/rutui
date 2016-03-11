module RuTui
	# A Pixel consists of foreground, background and a symbol.
	# Pixels are a central element of RuTui.
	#
	# Colors can be numbers between 0 and 255
	#
	# Note: Windows does need a extra software like ANSICON to
	# display more than a few (16) colors.
	#
	class Pixel
		attr_accessor :foreground, :background, :symbol
		attr_accessor :bold, :thin, :italic, :underline, :blink

		# create new pixel
		#
		# @param foreground [Integer, nil] foreground color
		# @param background [Integer, nil] background color
		# @param symbol [Text, nil] single char
		# @param [Hash] options additional pixel options
		# @option options [true,false,nil] :bold bold text
		# @option options [true,false,nil] :thin thin text
		# @option options [true,false,nil] :italic italic text
		# @option options [true,false,nil] :underline underline text
		# @option options [true,false,nil] :blink blink text
		def initialize foreground = 0, background = nil, symbol = " ", options = {}
			@foreground = foreground
			@background = background
			if symbol.nil?
				@symbol = nil
			else
				@symbol = symbol.to_s[0,1]
			end

			@bold = !!options[:bold]
			@thin = !!options[:thin]
			@italic = !!options[:italic]
			@underline = !!options[:underline]
			@blink = !!options[:blink]
		end

		# see {#background}
		def bg; @background end
		# see {#foreground}
		def fg; @foreground end

		# get a random pixel with optional symbol
		#
		# @param symbol [Text] single char
		# @return [RuTui::Pixel] random pixel
		def self.random symbol = " "
			new(rand(255),rand(255),symbol)
		end

		# get pixel hash
		#
		# @return [Hash] pixel as hash
		# @example
		#   { background: 12, foreground: 14, symbol: "~" }
		def to_h
			{ background: @background,
			 	foreground: @foreground,
				symbol: @symbol }.merge(options)
		end

		private
		# optional pixel options (bold, italic, thin, underline, blink)
		#
		# @return [Hash] pixel options hash
		def options
			options = {}
			options[:bold] = true if @bold
			options[:thin] = true if @thin
			options[:italic] = true if @italic
			options[:underline] = true if @underline
			options[:blink] = true if @blink
			options
		end
	end
end
