module RuTui
	## Textfield Object Class
	# Creates an Textfield element
	#
	# Methods:
	# 	:set_focus 		Set focus to this textfield
	#   :take_focus     Unset focus
	# 	:write CHAR 	Write char to textfield (if has focus)
	# 	:set_text TEXT 	Set text
	# 	:get_text 		Returns text
	# 	:count 			Text count
	#
	# Attributes (all accessible):
	# 	:x				MUST
	# 	:y				MUST
	#	:pixel			- pixel from which colors get inherted
	#   :focus_pixel    - pixel used when on focus (defaults to pixel)
	# 	:allow			- allowed chars
	# 	:password		- boolean: is password field?
	# 	:focus 			- has focus?
	#
	class Textfield < BaseObject
		attr_accessor :focus, :password, :allow

		def initialize options
			@width = 14
			@width = options[:width] if !options[:width].nil?

			@pixel = options[:pixel]
			@pixel = Theme.get(:border) if @pixel.nil?

			@focus_pixel = options[:focus_pixel]
			@focus_pixel = @pixel if @focus_pixel.nil?

			@x = options[:x]
			@x = 1 if @x.nil?
			@y = options[:y]
			@y = 1 if @y.nil?

			@allow = ('0'..'9').to_a + ('a'..'z').to_a + ('A'..'Z').to_a + [" ", ":", "<", ">", "|", "#",
				"@", "*", ",", "!", "?", ".", "-", "_", "=", "[", "]", "(", ")", "{", "}", ";"]
			@allow = options[:allow] if !options[:allow].nil?

			@height = 1

			@focus = false
			@password = false
			@password = true if options[:password] == true

			@text = ""

			create
		end

		##
		# set focus
		def set_focus
			@focus = true
			RuTui::Ansi.position @x, @y
			create
		end

		##
		# take focus
		def take_focus
			@focus = false
			create
		end

		##
		# count
		def count
			@text.size
		end

		##
		# write to textfield
		def write char
			if @focus
				@text += char if @allow.include? char
				@text = @text[0..-2] if char == :backspace or char == :ctrl_h # its 8 on windows
			end
			create
		end

		##
		# set text
		def set_text text
			@text = text
			create
		end

		##
		# get text
		def get_text
			@text
		end

		##
		# create or recreate the table object
		def create
			obj = []
			_obj = []
			if (@text.size+2) < @width
				text = @text
			else
				text = @text.split(//).last(@width).join("").to_s
			end

			if password
				_text = text
				text = ""
				_text.size.times do |i|
					text += "*"
				end
			end

			text.to_s.split("").each do |t|
				if @focus && @focus_pixel != @pixel
					_obj << Pixel.new(@focus_pixel.fg, @focus_pixel.bg, t)
				else
					_obj << Pixel.new(@pixel.fg, @pixel.bg, t)
				end
			end

			if @focus && @focus_pixel != @pixel
				_obj << Pixel.new(@focus_pixel.fg, @focus_pixel.bg, "_")
			else
				_obj << Pixel.new(@pixel.fg, @pixel.bg, "_")
			end
			obj << _obj
			@obj = obj
		end
	end
end
