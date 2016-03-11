module RuTui
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
      @bg = -1 if @bg.nil?
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
          t = RuTui::Ansi.bold(t) if @bold
          t = RuTui::Ansi.thin(t) if @thin
          t = RuTui::Ansi.italic(t) if @italic
          t = RuTui::Ansi.underline(t) if @underline
          t = RuTui::Ansi.blink(t) if @blink
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
end
