module RuTui
	## Simple themeing engine
	#
	# Themes always inherit from the current default theme
	# so make sure to set that first.
	#
	# Every object has a theme attached.
	# This can be ether the default theme, which exposes itself
	# as static in this class or a custom one, which is stored globally.
	#
	# This means when ever create theme :my_theme,
	# you can get it later with `get_theme(:my_theme)`
	# or even assign it as default with `default(:my_theme)`
	#
	# @example Create new theme
	#   Theme.new(:meh, text_color: 12) #=> <RuTui::Theme @current=:meh>
	class Theme
		@@themes = {}
		@@default = :default

		@@objects = {}
		@@themes = {
			default: {
				background: Pixel.new(236,234,":"),
				foreground: Pixel.new(11,nil," "),
				focus: Pixel.new(238,236,":"),
				rainbow: [1,3,11,2,4,5],
				border: {
					foreground: 144,
					background: 234,
					border_bottom: "─",
					border_top: "─",
					border_left: "│",
					border_right: "│",
					border_top_left: "┌",
					border_top_right: "┐",
					border_bottom_left: "└",
					border_bottom_right: "┘"
				},
				checkbox: {
					checked: "☑",
					unchecked: "☐"
				}
			}
		}

		# Create a new theme
		#
		# @param name [Symbol] the themes global unique name. `:my_theme`
		# @param theme [Hash] the theme hash, which will be merged with the current default
		# @param default [true, false] set the created theme as default
		def initialize name, theme = {}, default = false
			@current = name
			@@objects[@current] = self
			@@themes[@current] = @@themes[@@default].merge(theme)
			@@default = name if default
		end

		# Get value from theme instance
		#
		# @param key [Symbol] theme property name
		# @return [String, Hash, Integer, Array] whatever is behind that property
		def get key
			@@themes[@current][key]
		end

		# Set value from theme instance
		#
		# @param key [Symbol] theme property name
		# @param value [String, Hash, Integer, Array] whatever you need the property to be
		def set key, value
			@@themes[@current][key] = value
		end

		# Get value from default theme
		#
		# @param val [Symbol] theme property name
		# @return [String, Hash, Integer, Array] whatever is behind that property
		def self.get val
			@@themes[@@default][val]
		end

		# set or get default theme
		#
		# @param name [Symbol] default theme name
		# @return [Symbol] default theme name
		def self.default name = nil
			return @@default if name.nil?

			if !@@themes[name].nil?
				@@default = name
			else
				raise "Unknown theme"
			end
		end

		# get formerly created theme object by name
		#
		# @param name [Symbol] global theme name
		# @return [RuTui::Theme] stored theme object
		def self.get_theme name
			@@objects[name]
		end

		# get theme hash
		# see above in @@themes for a example
		#
		# @return [Hash] theme hash
		def to_h
			@@themes[@current]
		end

		# get the default theme hash
		#
		# @return [Hash] theme hash
		def self.to_h
			@@themes[@@default]
		end
	end
end
