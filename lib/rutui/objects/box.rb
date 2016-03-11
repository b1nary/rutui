module RuTui
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
end
