# Simple themeing engine
class Theme
	@@themes = {}
	@@use = :default

	# init themes
	def self.init
		@@themes[:default] = {
			:background => Pixel.new(236,234,":"),
			:border 		=> Pixel.new(144,234,"-"),
			:textcolor  => 11,
			:rainbow 		=> [1,3,11,2,4,5]
		}
		@@themes[:light] = {
			:background => Pixel.new(251,253,":"),
			:border 		=> Pixel.new(237,253,"-"),
			:textcolor  => 0,
			:rainbow 		=> [1,3,11,2,4,5]
		}
		@@themes[:basic] = {
			:background => Pixel.new(0,14," "),
			:border 		=> Pixel.new(8,14,"-"),
			:textcolor  => 0,
			:rainbow 		=> [1,2,3,4,5,6]
		}
	end

	# Create new theme
	def self.create name, theme
		@@themes[name] = theme
	end

	# Delete theme
	def self.delete name
		@@themes.delete(name)
	end

	# Set value from current theme
	def self.set key, val
		@@themes[@@use][key] = val
	end

	# Get value from current theme
	def self.get val
		@@themes[@@use][val]
	end

	# set current theme
	def self.use name
		@@use = name if !@@themes[name].nil?
	end

end

Theme.init
