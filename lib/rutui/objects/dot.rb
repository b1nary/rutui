module RuTui
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
end
