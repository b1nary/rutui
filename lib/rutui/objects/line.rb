module RuTui
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
end
