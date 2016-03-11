module RuTui
	## Base Object Class
	# Dynamic Objects that get drawn on the Screen
	# This class is used as basic class for other objects
	#
	class BaseObject
		attr_accessor :x, :y, :width, :height, :obj
		# Ex.: BaseObject.new({ :x => 1, :y => 20, :obj => [[Pixel.new(1),Pixel.new(2,4,"#")]] })
		def initialize options
			@obj = options[:obj]
			@obj = Array.new(height){ Array.new(width) } if @obj.nil?

			@x = options[:x]
			@y = options[:y]
			@x = 1 if @x.nil?
			@y = 1 if @y.nil?

			@height = @obj.size
			@width  = @obj[0].size
		end

		# Move object X and Y (modifiers like: -2, 2)
		def move x, y; @x += x; @y += y; end
		# Set object position X Y
		def set_position x, y; @x = x; @y = y; end
		# Set pixel on position on object
		def set_pixel x, y, pixel
			@obj[x][y] = pixel if !@obj[x].nil? and !@obj[x][y].nil?
		end
		# Get pixel by position
		def get_pixel x, y
			@obj[x][y] if !@obj[x].nil? and !@obj[x][y].nil?
		end

		# "special" each methods for objects
		def each
			return if @obj.nil?
			@obj.each_with_index do |row,row_count|
				row.each_with_index do |pixel,col_count|
					yield row_count, col_count, pixel
				end
			end
		end
	end

end
