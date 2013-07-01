#
# Generated one file script of rutui
# This file is commandless and stripped down
# For full source please visit:
#   https://github.com/b1nary/rutui
#
# Author: Roman Pramberger (roman.pramberger@gmail.com)
# License: MIT
#
# Son Jul 22 19:06:05 CEST 2012
#
class RuTui
class Color
	# Calculate color from RGB values
	def self.rgb(red, green, blue);	16 + (red * 36) + (green * 6) + blue; end
	# Set background color
	def self.bg color; "\x1b[48;5;#{color}m"; end
	# Set text color
	def self.fg color; "\x1b[38;5;#{color}m"; end
	# "Shortcut" to background color
	def self.background color; self.bg color; end
	# "Shortcut" to foreground/text color
	def self.foreground color; self.fg color; end
	# Clear all color
	def self.clear_color; "\x1b[0m"; end
	# Clear Screen/Terminal
	def self.clear; "\e[2J\e[1;1H"; end
end
class Utils
	# Get Windows size
	def self.winsize
		#begin
		#	require "io/console"
		#	row, col = $stdout.winsize
		#	return [row, col]
		#rescue
		#	if !ENV["LINES"].nil? and !ENV["COLUMNS"].nil?
		#		return [ENV["LINES"], ENV["COLUMNS"]]
		#	else
				return [Integer(`tput lines`), Integer(`tput cols`)]
		#	end
		end
	end
	# Get input char without enter 
	# UNIX only! 
	def self.gets
		# Win32API.new("crtdll", "_getch", [], "L").Call).chr
		begin
			system("stty raw -echo")
			str = STDIN.getc
		ensure
			system("stty -raw echo")
		end
		return str
	end
	# Hides the cursor
	def self.init
		system("tput civis")
	end
	# Brings the cursor back
	def self.clear
		system("tput cnorm")
	end
end
class Pixel
	attr_accessor :fg, :bg, :symbol
	def initialize foreground = 15, background = nil, symbol = " "
			@fg = foreground
			@bg = background
			@symbol = symbol
	end
	def self.random sym = "#"
		Pixel.new(rand(255),rand(255),sym)
	end
end
class Theme
	@@themes = {}
	@@use = :default
	# init themes
	def self.init
		@@themes[:default] = {
			:background => Pixel.new(236,234,":"),
			:border 		=> Pixel.new(144,234,"-"),
			:textcolor  => 11,
			:rainbow 		=> [1,3,11,2,4,5]
		}
		@@themes[:light] = {
			:background => Pixel.new(251,253,":"),
			:border 		=> Pixel.new(237,253,"-"),
			:textcolor  => 0,
			:rainbow 		=> [1,3,11,2,4,5]
		}
	end
	# Create new theme
	def self.create name, theme
		@@themes[name] = theme
	end
	# Delete theme
	def self.delete name
		@@themes.delete(name)
	end
	# Set value from current theme
	def self.set key, val
		@@themes[@@use][key] = val
	end
	# Get value from current theme
	def self.get val
		@@themes[@@use][val]
	end
	# set current theme
	def self.use name
		@@use = name if !@@themes[name].nil?
	end
end
Theme.init
class BaseObject
	attr_accessor :x, :y, :width, :height, :obj
	# Ex.: BaseObject.new({ :x => 1, :y => 20, :obj => [[Pixel.new(1),Pixel.new(2,4,"#")]] })
	def initialize options
		@obj = options[:obj]
		@obj = Array.new(height){ Array.new(width) } if @obj.nil?
		@x = options[:x]
		@y = options[:y]
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
	# "special" each methods for objects
	def each 
		@obj.each_with_index do |row,row_count|
			row.each_with_index do |pixel,col_count|
				yield row_count, col_count, pixel
			end
		end
	end
end
class Box < RuTui::BaseObject
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
class Line < BaseObject
	attr_accessor :length, :pixel, :endpixel, :direction
	def initialize options
		@x = options[:x]
		@y = options[:y]
		@length = options[:length]
		@direction = options[:direction]
		@direction = :horizontal if @direction.nil?
		return if @x.nil? or @y.nil? or @width.nil?
		@pixel = options[:pixel]
		@endpixel = options[:endpixel]
		@pixel = Theme.get(:border) if @pixel.nil?
		create
	end
	# Create Line
	# can be recalled any time on attribute changes
	def create
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
class Text < BaseObject
	attr_accessor :bg, :fg, :text, :do_rainbow
	@@rainbow = nil
	def initialize options
		@@rainbow = Theme.get(:rainbow) if @@rainbow.nil?
		@do_rainbow = options[:rainbow]
		@text = options[:text]
		@x = options[:x]
		@y = options[:y]
		@bg = options[:background]
		@fg = options[:foreground]
		@bg = Theme.get(:background).bg if @bg.nil?
		@fg = Theme.get(:textcolor) if @fg.nil?
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
		tmp = []
		@text.split("").each do |t|
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
	def set_text text
		@text = text
		create
	end
end
class Screen
	# Initialize me with a default pixel, if you want
	def initialize default_pixel = Theme.get(:background)
		size = Utils.winsize
		@smap = Array.new(size[0]){ Array.new(size[1]) }
		@map = @smap.dup
		@default = default_pixel
		@objects = []
		@statics = []
		# Set as default if first screen
		ScreenManager.add :default, self if ScreenManager.size == 0
	end
	# regen screen (size change?)
	def rescreen
		size = Utils.winsize
		@smap = Array.new(size[0]){ Array.new(size[1]) }
		@statics.each do |s|
			self.add_static s
		end
		@map = @smap.dup
	end
	# Set default/background pixel
	#  Ex.: screen.set_default Pixel.new(244,1,";")
	def set_default pixel
		@default = pixel
	end
	# Get default/background pixel
	def get_default
		@default
	end
	# add object that doesnt change over time
	def add_static object
		@statics << object if !@statics.include? object
		object.each do |ri,ci,pixel|
			@smap[object.y+ri][object.x+ci] = pixel if !pixel.nil? and object.y+ri > 0 and object.y+ci > 0
		end
	end
	# add dynamic object
	def add object
		@objects << object
	end
	# draw the pixel-screen map
	def draw
		lastpixel = Pixel.new(rand(255), rand(255), ".")
		@map = Marshal.load( Marshal.dump( @smap )) # Deep copy
		# get all the objects
		@objects.each do |o|
			next if o.x.nil? or o.y.nil? 
			o.each do |ri,ci,pixel|
				@map[o.y + ri][o.x + ci] = pixel if !pixel.nil? and o.y+ri > 0 and o.x+ci > 0 and o.y+ri < @map.size and o.x+ci < @map[0].size
			end
		end
		# an DRAW!
		@map.each do |line|
			line.each do |pixel|
				if pixel != lastpixel
					print Color.clear_color if lastpixel != 0
					if pixel.nil?
						lastpixel = pixel
						print "#{Color.bg(@default.bg)}#{Color.fg(@default.fg)}#{@default.symbol}"
					else
						lastpixel = pixel
						print "#{Color.bg(pixel.bg)}#{Color.fg(pixel.fg)}#{pixel.symbol}"
					end
				else
					if pixel.nil?
						print @default.symbol
					else
						print pixel.symbol
					end
				end
			end
		end
	end
end
class ScreenManager
	@@screens = {}
	@@current = :default
	# Set a screen
	#  Ex.: ScreenManager.set :default, Screen.new
	def self.add name, screen
		@@screens[name] = screen
	end
	# Get count of existing screens
	def self.size
		@@screens.size
	end
	# Delete screen by name
	def self.delete name
		@@screens.delete(name) if !@@screens[name].nil?
	end
	# Set current screen
	def self.set_current name
		@@current = name
	end
	# Get current screen
	def self.get_current
		# Fix size and others of screen here
		@@current
	end
	# Get the complete screen by name
	def self.get_screen name
		@@screens[name]
	end
	# Refit screen size
	def self.refit
		size = Utils.winsize
		if @autofit or size != @lastsize
			@@screens[@@current].rescreen
			@lastsize = size
		end
	end
	# draw current screen
	def self.draw
		print Color.clear
		@@screens[@@current].draw
	end
	# Raw Game Loop
	#  Ex.: ScreenManager.loop({ :autodraw => true, :autofit => true }){ |key| p key } 
	def self.loop options
		autodraw = options[:autodraw]
		@autofit = options[:autofit]
		@autofit = true if @autofit.nil?
		@lastsize = nil
		Utils.init
		ScreenManager.draw
		while true
			key = Utils.gets
			yield key
			ScreenManager.refit if @autofit
			ScreenManager.draw if autodraw
		end
	end
end
class Figlet < BaseObject
	attr_accessor :text, :rainbow, :font, :colors
	# Figlet font: '!" #$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz[|]~ÄÖÜäöüß'
	@@chars = '!!"#$%&\'()*+,-./0123456789:;<=>?@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_`abcdefghijklmnopqrstuvwxyz[|]~ÄÖÜäöüß'.split("")
	@@rainbow = nil
	@@fonts = {}
	# Initialize (see above)
	def initialize options
		@x = options[:x]
		@y = options[:y]
		@@rainbow = Theme.get(:rainbow) if @@rainbow.nil?
		return if @x.nil? or @y.nil?
		@font = options[:font]
		@text = options[:text]
		@rainbow = options[:rainbow]
		@space = options[:space]
		@space = 0 if @space.nil?
		@colors = options[:colors]
		@colors = [Pixel.new(Theme.get(:textcolor))] if @colors.nil?
		create
	end
	
	# Create Figlet text object
	# Recall it any time when attributes have changed
	def create
		obj = []
		@@fonts[@font]['n'].size.times do 
			obj << []
		end
		p obj
		current = 0
		p @@fonts[@font]['F']
		p @@fonts[@font]['L']
		count = 0
		@text.each_byte do |c|
			if @@chars.include? c.chr
				@@fonts[@font][c.chr].each_with_index do |fr,ri|
					fr.each do |fc|
						if @rainbow
							obj[ri] << Pixel.new(@@rainbow[current], @colors[0].bg,fc)
						else
							obj[ri] << Pixel.new(@colors[current].fg,@colors[current].bg,fc)
						end
						if @rainbow != true
							current += 1 if @colors.size > 1
							current = 0 if current > @colors.size
						end
					end
				end
				if @rainbow
					current += 1
					current = 0 if current >= @@rainbow.size
				end
				if count < @text.size-1
					@@fonts[@font]['n'].size.times do |ri|
						@space.times do
							if @rainbow
								obj[ri] << Pixel.new(@@rainbow[current], @colors[0].bg," ")
							else
								obj[ri] << Pixel.new(@colors[current].fg,@colors[current].bg," ")
							end
						end
					end
				end
			# SPace
			elsif c.chr == " "
				@@fonts[@font]['n'].size.times do |ri|
					3.times do
						if @rainbow
							obj[ri] << Pixel.new(@@rainbow[current], @colors[0].bg," ")
						else
							obj[ri] << Pixel.new(@colors[current].fg,@colors[current].bg," ")
						end
					end
				end
			end
			count += 1
		end
		@obj = obj
	end
	# Static methods to add/load new Fonts
	def self.add name, file
		if File.exists?(file)
			data = File.new(file, "r").read.split("\n")
			config = data[0].split(" ")
			# Remove Comments (Size is in info line)
			config[5].to_i.times do 
				data.delete_at(0)
			end
			# Remove empty line if exist
			data.delete_at(0) if data[0].strip() == ""
			height = config[2].to_i
			rest = config[1].to_i - height
			@@fonts[name] = {}
			
			@@chars.each do |i|
				out = []
				(data.delete_at(0); rest -= 1) if data.size > 0 and data[0].gsub('$@','').gsub(' ','') == ''
				height.times do |x|
					break if data.size < 1
					xdata = data[0].gsub("$"," ").gsub("@","").gsub("\r","").split("")
					out << xdata if xdata.size > 0
					data.delete_at(0)
				end
				rest.times do
					data.delete_at(0)
				end
				@@fonts[name][i] = out
			end
			return true
		else
			return false
		end
	end
end
class Axx < BaseObject
	def initialize options
		@x = options[:x]
		@y = options[:y]
		@file = options[:file]
		@attr, @xx, @yy, @save_x, @save_y, @attr = 0,0,0,0,0,0
		return if @x.nil? or @y.nil? or @file.nil?
		return if !File.exists? @file
		@img = File.open(@file).read
		self.parse
	end
	def parse
		
	end
end
class Axx < BaseObject
	def initialize options
		@file = options[:file]
		return if @file.nil?
		return if !File.exists? @file
		@img = File.open(@file).read
		parse
	end
	def parse
		out = []
		@img.split("\n").each_with_index do |line,li|
			if !line.match(/^#/)
				out[li] = []
				line.split("|").each_with_index do |elem,ei|
					ele = elem.split(":")
					if ele.size == 3
						out[li][ei] = Pixel.new(ele[1].to_i,ele[2].to_i,ele[0])
					elsif ele.size == 2
						out[li][ei] = Pixel.new(ele[1].to_i,nil,ele[0])
					else
						if ele[0] == "nil"
							out[li][ei] = nil
						else
							out[li][ei] = Pixel.new(nil,nil,ele[0])
						end
					end
				end
			end
		end
		out.each do |o|
			out.delete(o) if o.nil?
		end
		@obj = out
		@height = out.size
		@width = out.size
	end
	def self.parse data
		out = []
		data.split("\n").each_with_index do |line,li|
			if !line.match(/^#/)
				out[li] = []
				line.split("|").each_with_index do |elem,ei|
					ele = elem.split(":")
					if ele.size == 3
						out[li][ei] = Pixel.new(ele[1].to_i,ele[2].to_i,ele[0])
					elsif ele.size == 2
						out[li][ei] = Pixel.new(ele[1].to_i,nil,ele[0])
					else
						if ele[0] == "nil"
							out[li][ei] = nil
						else
							out[li][ei] = Pixel.new(nil,nil,ele[0])
						end
					end
				end
			end
		end
		out.each do |o|
			out.delete(o) if o.nil? or o == []
		end
		return out
	end
end
class Sprite < BaseObject
	attr_accessor :tick, :current, :sprites, :ticks, :object
	@@spr = []
	def initialize options
		@x = options[:x]
		@y = options[:y]
		@x = 0 if @x.nil?
		@y = 0 if @y.nil?
		@tick = 0
		@object = options[:obj]
		@file = options[:file]
		@current = nil
		@@spr << self
		@sprites = {}
		create_from_file if !@file.nil?
	end
	def create_from_file
		if File.exists? @file
			data = File.open(@file).read
			# AXX Format
			if data.include? '---' and data.include? '| :' 
				out = []
				data = data.split("---")
				while data.size > 0
					while data[0].match(/^#/)
						data.shift
					end
					name = data.shift
					content = data.shift
					@sprites[name] = [] if @sprites[name].nil?
					@sprites[name] << Axx.parse(content)
					@current = name if @current.nil? # first sprite gets default
					@obj = @sprites[@current][0]
				end
			end
		end
	end
	# set current animation
	def set_current name
		@current = name
		@obj = @sprites[@current][0]
	end
	# Add sprite
	def add name, images
		@current = name if @current.nil? # first sprite gets default
		@sprites[name] = images
	end
	# Update ticker
	def update
		@tick += 1
		@tick = 0 if @tick >= ( @sprites[@current].size )
		@obj = @sprites[@current][@tick]
	end
end
end
