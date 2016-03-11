module RuTui
  # A single simple dot
  class Dot < BaseObject
    attr_reader :foreground
    attr_reader :background
    attr_reader :symbol
    # Create a new Dot
		#
		# @param [Hash] options the default options to create a Dot with.
		# @option options [Integer,nil] :foreground Foreground color for the dot (default: Default Theme)
    # @option options [Integer,nil] :background Background color for the dot (default: Default Theme)
    # @option options [String,nil] :symbol Symbol for the dot (default: Default Theme)
		#
		# @example
		#   Dot.new(x: 4, y: 2, foreground: 12, background: nil, symbol: "@")
    def initialize options = {}
      super(options)
      options = @theme.get(:foreground).to_h.merge(options)
      @foreground = options[:foreground]
      @background = options[:background]
      @symbol     = options[:symbol]
      recreate
    end

    # Set foreground color (and recreate object)
    #
    # @param foreground [Integer] set foreground/text color
    def foreground=(foreground)
      @foreground = foreground
      recreate
    end

    # Set background color (and recreate object)
    #
    # @param background [Integer] set background color
    def background=(background)
      @background = background
      recreate
    end

    # Set symbol (and recreate object)
    #
    # @param symbol [Integer] set symbol
    def symbol=(symbol)
      @symbol = symbol
      recreate
    end

    # Recreate the object
    def recreate
      @object = [[ Pixel.new(@foreground, @background, @symbol) ]]
      super
    end
  end
end
