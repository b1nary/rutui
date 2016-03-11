module RuTui
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
end
