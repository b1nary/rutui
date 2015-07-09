## Checkbox Object Class
# Creates an Checkbox element
#
# Methods:
# 	:set_focus 		Set focus to this textfield
#   :take_focus     Unset focus
#   :toggle         Toggle checkbox
#   :check          Check
#   :uncheck        Uncheck
#
# Attributes (all accessible):
# 	:x				MUST
# 	:y				MUST
#	:pixel			- pixel from which colors get inherted
#   :focus_pixel    - pixel used when on focus (defaults to pixel)
# 	:focus 			- has focus?
#   :checked		- is checked?
#   :symbol_checked - symbol if checked
#   :symbol_unchecked - symbol if unchecked
#
class Checkbox < BaseObject
	attr_accessor :focus, :checked

	def initialize options
		@pixel = options[:pixel]
		@pixel = Theme.get(:border) if @pixel.nil?

		@focus_pixel = options[:focus_pixel]
		@focus_pixel = @pixel if @focus_pixel.nil?

		@symbol_checked = options[:symbol_checked]
		@symbol_checked = "☑" if @symbol_checked.nil?

		@symbol_unchecked = options[:symbol_unchecked]
		@symbol_unchecked = "☐" if @symbol_unchecked.nil?

		@x = options[:x]
		@x = 1 if @x.nil?
		@y = options[:y]
		@y = 1 if @y.nil?

		@focus = options[:focus]
		@focus = false if @focus.nil?

		@checked = options[:checked]
		@checked = false if @checked.nil?

		create
	end

	def set_focus
		@focus = true
		create
	end

	def take_focus
		@focus = false
		create
	end

	def toggle
		if @checked
			self.uncheck
		else
			self.check
		end
	end

	def check
		@checked = true
		create
	end

	def uncheck
		@checked = false
		create
	end

	private

	def create
		if @focus
			@obj = [[@focus_pixel]]
		else
			@obj = [[@pixel]]
		end

		if @checked
			@obj[0][0].symbol = @symbol_checked
		else
			@obj[0][0].symbol = @symbol_unchecked
		end
	end

end
