# This class contains different Objects

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

## Box Class
# draw a box with borders
#
# Attributes (all accessible):
#	:width							*	Box width
#	:height 						*	Box height
# 	:x								*	Box X MUST
#	:y								*	Box Y MUST
#	:horizontal						Horizontal Pixel
#	:vertical						Vertical Pixel
#	:corner							Corner Pixel
#	:fill							Between the border lines (Color)
#
# Example:
#  Box.new({ :x => 1, :y => 42, :width => 10, :height => 5, :corner => Pixel.new(1,2,"#"), :fill => Pixel.new(4,6,":") })
#
class Box < BaseObject
	attr_accessor :fill, :width, :height, :vertical, :horizontal, :corner

	# initialize object (see above)
	def initialize options
		@x = options[:x]
		@y = options[:y]
		@width = options[:width]
		@height = options[:height]

		return if @x.nil? or @y.nil? or @width.nil? or @height.nil?

		@fill = options[:fill]

		@vertical   = options[:vertical]
		@horizontal = options[:horizontal]
		@corner   	= options[:corner]
		ref = Theme.get(:border)
		@horizontal = Pixel.new(ref.fg,ref.bg,"-") if options[:horizontal].nil?
		@vertical   = Pixel.new(ref.fg,ref.bg,"|") if options[:vertical].nil?
		@corner     = Pixel.new(ref.fg,ref.bg,"*") if options[:corner].nil?

		@width = 3 if @width < 3
		@height = 3 if @height < 3

		create
	end

	# Create Box
	# can be recalled any time on attribute changes
	def create
		if !@fill.nil?
			backpixel = Pixel.new(@fill.fg,@fill.bg,@fill.symbol)
			obj = Array.new(@height){ Array.new(@width) { backpixel } }
		else
			obj = Array.new(@height){ Array.new(@width) }
		end

		(@width-2).times do |i|
			obj[0][i+1] = @horizontal
			obj[@height-1][i+1] = @horizontal
		end

		(@height-2).times do |i|
			obj[i+1][0] = @vertical
			obj[i+1][@width-1] = @vertical
		end

		obj[0][0] = @corner
		obj[0][@width-1] = @corner
		obj[@height-1][0] = @corner
		obj[@height-1][@width-1] = @corner

		@height = obj.size
		@width = obj[0].size
		@obj = obj
	end
end


## Line Class
# draw a straight line
#
# Attributes (all accessible)
# 	:x				MUST
# 	:y				MUST
#	:direction  	:vertical|:horizontal (Default: :horizontal)
#	:length
#	:pixel
#	:endpixel
#
class Line < BaseObject
	attr_accessor :length, :pixel, :endpixel, :direction

	def initialize options
		@x = options[:x]
		@y = options[:y]
		@length = options[:length]
		@direction = options[:direction]
		@direction = :horizontal if @direction.nil?

		return if @x.nil? or @y.nil? or @length.nil?
		@pixel = options[:pixel]
		@endpixel = options[:endpixel]

		@pixel = Theme.get(:border) if @pixel.nil?

		create
	end

	# Create Line
	# can be recalled any time on attribute changes
	def create
		@obj = []
		if @direction == :horizontal
			@obj = [Array.new(@length){ @pixel }]
		else
			@obj = Array.new(@length){ [@pixel] }
		end
		if !@endpixel.nil?
			@obj[0][0] = @endpixel
			@obj[0][@length-1] = @endpixel
		end
	end
end

## Circle Class
# draw a circle
#
# thx to: http://rubyquiz.strd6.com/quizzes/166-circle-drawing
#
# Attributes (all accessible):
# 	:x			MUST
# 	:y			MUST
# 	:radius		- Circle radius
# 	:pixel		- Circle Pixel
# 	:fill		- Actually just fills the box not the circle...
#
class Circle < BaseObject
	attr_accessor :radius, :pixel, :fill
	# Initialize circle (see above)
	def initialize options
		@x = options[:x]
		@y = options[:y]
		@radius = options[:radius]
		@pixel = options[:pixel]
		@fill = options[:fill_pixel]

		@pixel = Theme.get(:border) if @pixel.nil?

		return if @x.nil? or @y.nil? or @radius.nil?

		@width = options[:radius]*2 # needed?
		@height = @width # needed?

		create
	end

	# Create Circle
	# can be recalled any time on attribute changes
	def create
		obj = []
		(0..(@radius*2)).each do |x|
			(0..(@radius*2)).each do |y|
				obj[y] = [] if obj[y].nil?
				obj[y][x] = distance_from_center(x,y).round == @radius ? @pixel : @fill
			end
		end
		@obj = obj
	end

	private
	def distance_from_center(x,y)
		a = calc_side(x)
		b = calc_side(y)
		return Math.sqrt(a**2 + b**2)
	end

	def calc_side(z)
		z < @radius ? (@radius - z) : (z - @radius)
	end

end

## Text Object Class
# Creates an Text element
#
# Attributes (all accessible):
# 	 :x				MUST
# 	 :y				MUST
#	 :text			- the text to draw
#	 :background	- Background color (0-255)
#	 :foreground 	- Foreground color (0-255)
#    :max_width 	- with max_width defined text breaks to next line automatically
# 	 :rainbow 		- true|false|none	Rainbow text
#    :bold 			- true|false|nil	Bold text
#    :italic        - true|false|nil	Italic text (Not supported everywhere)
#    :thin	        - true|false|nil	Thin text (Not supported everywhere)
#    :underline     - true|false|nil	Underline text (Not supported everywhere)
#    :blink	        - true|false|nil	Blink text (Not supported everywhere)
#
class Text < BaseObject
	attr_accessor :bg, :fg, :text, :do_rainbow, :bold,
		:thin, :italic, :underline, :blink, :max_width, :pixel
	@@rainbow = nil

	def initialize options
		@do_rainbow = options[:rainbow]
		if @do_rainbow
			@@rainbow = Theme.get(:rainbow) if @@rainbow.nil?
		end
		@text = options[:text]
		@x = options[:x]
		@y = options[:y]
		@pixel = options[:pixel]
		@bg = options[:background]
		@fg = options[:foreground]
		if !@pixel.nil?
			@bg = @pixel.bg
			@fg = @pixel.fg
		end
		@bg = Theme.get(:background).bg if @bg.nil?
		@fg = Theme.get(:textcolor) if @fg.nil?
		@bold 		= options[:bold] || false
		@thin 		= options[:thin] || false
		@italic 	= options[:italic] || false
		@underline 	= options[:underline] || false
		@blink 		= options[:blink] || false
		@max_width 	= options[:max_width]
		return if @x.nil? or @y.nil?

		@height = 1
		create
	end

	# Create Text
	# can be recalled any time on attribute changes
	def create
		if @do_rainbow
			rainbow = 0
		end
		@width = @text.size
		@obj = []

		texts = [@text]
		if !@max_width.nil?
			texts = @text.chars.each_slice(@max_width).map(&:join)
		end

		texts.each do |l|
			tmp = []
			l.split("").each do |t|
				t = Ansi.bold(t) if @bold
				t = Ansi.thin(t) if @thin
				t = Ansi.italic(t) if @italic
				t = Ansi.underline(t) if @underline
				t = Ansi.blink(t) if @blink
				if @do_rainbow
					tmp << Pixel.new(@@rainbow[rainbow],@bg,t)
					rainbow += 1
					rainbow = 0 if rainbow >= @@rainbow.size
				else
					tmp << Pixel.new(@fg,@bg,t)
				end
			end
			@obj << tmp
		end
	end

	def set_text text
		@text = text
		create
	end

	def get_text
		@text
	end
end

## Dot Object Class
# Single pixel element
#
# Attributes (all accessible):
# 	:x				MUST
# 	:y				MUST
#	:pixel			MUST - Pixel
#
class Dot < BaseObject
	def initialize options
		@x = options[:x]
		@y = options[:y]
		@pixel = options[:pixel]
		return if @x.nil? or @y.nil? or @pixel.nil?
		create
	end

	def create
		@obj = [[ @pixel ]]
	end
end
