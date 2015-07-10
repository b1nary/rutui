# This File contains the Screen Class

module RuTui
	## Screen Class
	# The Screen is the root element of your app.
	# Its basicly a map containing you screens pixels
	#
	class Screen
		# Initialize me with a default pixel, if you want
		def initialize default_pixel = Theme.get(:background)
			size = Utils.winsize
			@smap = Array.new(size[0]){ Array.new(size[1]) }
			@map = @smap.dup
			@default = default_pixel
			@objects = []
			@statics = []
			# Set as default if first screen
			ScreenManager.add :default, self if ScreenManager.size == 0
		end

		# regen screen (size change?)
		def rescreen
			size = Utils.winsize
			@smap = Array.new(size[0]){ Array.new(size[1]) }

			@statics.each do |s|
				self.add_static s
			end

			@map = @smap.dup
		end

		# Set default/background pixel
		#  Ex.: screen.set_default Pixel.new(244,1,";")
		def set_default pixel
			@default = pixel
		end

		##
		# Get default/background pixel
		def get_default
			@default
		end

		##
		# add object that doesnt change over time
		def add_static object
			@statics << object if !@statics.include? object
			object.each do |ri,ci,pixel|
				@smap[object.y+ri][object.x+ci] = pixel if !pixel.nil? and object.y+ri >= 0 and object.y+ci >= 0
			end
		end

		##
		# add dynamic object
		def add object
			@objects << object
		end

		##
		# remove object
		def delete object
			@objects.delete(object)
		end

		##
		# draw the pixel-screen map
		def draw
			lastpixel = Pixel.new(rand(255), rand(255), ".")
			@map = Marshal.load( Marshal.dump( @smap )) # Deep copy

			# get all the objects
			@objects.each do |o|
				next if o.x.nil? or o.y.nil?
				o.each do |ri,ci,pixel|
					if !pixel.nil? and o.y+ri >= 0 and o.x+ci >= 0 and o.y+ri < @map.size and o.x+ci < @map[0].size
						# -1 enables a "transparent" effect
						if pixel.bg == -1
							pixel.bg = @map[o.y + ri][o.x + ci].bg if !@map[o.y + ri][o.x + ci].nil?
							pixel.bg = Theme.get(:background).bg if pixel.bg == -1
						end
						if pixel.fg == -1
							pixel.fg = @map[o.y + ri][o.x + ci].fg if !@map[o.y + ri][o.x + ci].nil?
							pixel.fg = Theme.get(:background).fg if pixel.fg == -1
						end
						@map[o.y + ri][o.x + ci] = pixel
					end
				end
			end

			out = "\r\n" # Color.go_home
			# and DRAW!
			@map.each do |line|
				line.each do |pixel|
					if pixel != lastpixel
						out += RuTui::Ansi.clear_color if lastpixel != 0
						if pixel.nil?
							lastpixel = pixel
							out += "#{RuTui::Ansi.bg(@default.bg)}#{RuTui::Ansi.fg(@default.fg)}#{@default.symbol}"
						else
							lastpixel = pixel
							out += "#{RuTui::Ansi.bg(pixel.bg)}#{RuTui::Ansi.fg(pixel.fg)}#{pixel.symbol}"
						end
					else
						if pixel.nil?
							out += @default.symbol
						else
							out += pixel.symbol
						end
					end
				end
				out += "\r\n"
			end

			# draw out
			print out.chomp
			$stdout.flush
		end
	end
end
