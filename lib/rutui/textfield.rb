## Textfield Object Class
# Creates an Textfield element
#
# Methods:
# 	:set_focus 		Set focus to this textfield
# 	:write CHAR 	Write char to textfield (if has focus)
# 	:set_text TEXT 	Set text
# 	:get_text 		Returns text
# 	:count 			Text count
#
# Attributes (all accessible):
# 	:x				MUST
# 	:y				MUST
#	:pixel			- pixel from which colors get inherted
# 	:allow			- allowed chars
# 	:password		- boolean: is password field?
# 	:focus 			- has focus?
#
class Textfield < BaseObject
	attr_accessor :focus, :password, :border, :allow

	def initialize options
		@width = 14
		@width = options[:width] if !options[:width].nil?

		@pixel = options[:pixel]
		@pixel = Theme.get(:border) if @pixel.nil?

		@x = options[:x]
		@x = 1 if @x.nil?
		@y = options[:y]
		@y = 1 if @y.nil?

		@allow = (0..9).to_a + ('a'..'z').to_a + ('A'..'Z').to_a + [" ", ":", "<", ">", "|", "#", 
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
		Ansi.position @x, @y
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
			@text += char.chr if @allow.include? char.chr
			@text = @text[0..-2] if char == 127
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
			text = 0
			_text.size.times do |i|
				text += "*"
			end
		end

		text.to_s.split("").each do |t|
			_obj << Pixel.new(@pixel.fg, @pixel.bg, t)
		end
		
		_obj << Pixel.new(@pixel.fg, @pixel.bg, "_")
		obj << _obj
		@obj = obj
	end
end