module RuTui
  # Box is used to draw rectangles
  class Rectangle < BaseObject
    # initialize object (see above)
    def initialize options
      @has_border = options[:has_border]
      recreate
    end

    # Create Box
    # can be recalled any time on attribute changes
    def recreate
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

      @object = obj
      calculate_size
    end
  end
end
