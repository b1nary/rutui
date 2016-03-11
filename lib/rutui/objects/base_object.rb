module RuTui
	# Base Object
	#
	# Parent class for everything that gets drawn on the screen
	#
	class BaseObject
		attr_accessor :x, :y, :width, :height, :object, :theme
		# Create new BaseObject
		#
		# @param [Hash] options the default options to create a object with.
		# @option options [Integer] :x Object x position (default: 1)
		# @option options [Integer] :y Object y position (default: 1)
		# @option options [Array] :object A 2d pixel array the "object"
		# @option options [Symbol,Hash,Theme,true] :theme a optional theme as :symbol (via name), theme object, or create a new one with options trough a hash or clone of the default by true (default: Default theme)
		#
		# @example
		#   BaseObject.new({ x: 1, y: 20, object: [[Pixel.new(1),Pixel.new(2,4,"#")]] })
		def initialize options
			options = { x: 1,	y: 1 }.merge(options)
			if @object.nil? && options[:object]
				@object = options[:object]
			end
			if @object.nil? && options[:height] && options[:width]
				@object = Array.new(options[:height]){ Array.new(options[:width]) }
			end

			case options[:theme]
			when Theme
			  @theme = options[:theme]
			when Hash
			  @theme = Theme.new(:"t#{rand(99999)}a#{rand(99999)}", options[:theme])
			when true
			  @theme = Theme.new(:"t#{rand(99999)}a#{rand(99999)}")
			when Symbol
				@theme = Theme.get_theme(options[:theme])
			else
			  @theme = Theme
			end

			@x = options[:x]
			@y = options[:y]

			recreate
		end

		# Move object X and Y (modifiers like: -2, 2)
		#
		# @param x [Integer] x modifier
		# @param y [Integer] y modifier
		def move x, y; @x += x; @y += y; end

		# Set object position X Y
		#
		# @param x [Integer] x position
		# @param y [Integer] y position
		def set_position x, y; @x = x; @y = y; end

		# Re recalculate size based on object
		def calculate_size
			@height = @object.size
			@width  = @object.first.size
		end

		# recreate object
		def recreate
			calculate_size
		end

		# Get pixel by position
		#
		# @param x [Integer] pixel x position
		# @param y [Integer] pixel y position
		# @return [RuTui::Pixel] returns given pixel (can be nil)
		def get_pixel x, y
			@object[x][y]
		end

		# Set pixel on position on object
		#
		# @param x [Integer] pixel x position
		# @param y [Integer] pixel y position
		def set_pixel x, y, pixel
			@object[x][y] = pixel
		end

		# each row and column
		#
		# @yield [x, y, pixel]
		def each
			return if @object.nil?
			@object.each_with_index do |row,row_count|
				row.each_with_index do |pixel,col_count|
					yield row_count, col_count, pixel
				end
			end
		end
	end

end
