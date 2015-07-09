## Table Object Class
# Creates an Table element
#
# Attributes (all accessible):
# 	:x				MUST
# 	:y				MUST
#	:table			- the tabular data in an array (like: [[1,"A"], [2, "B"]])
#	:background		- Background color (0-255)
#	:foreground 	- Foreground color (0-255)
# 	:hover			- Hover color (0-255)
# 	:ascii 			- Draw ASCII decoration
#   :highlight 		- To highlight line
# 	:highlight_direction - Highlight direction
#   :cols 			- Header and meta definitions (see example)
# 	:pixel 			- Default pixel (colors) for border
#
class Table < BaseObject
	attr_accessor :table, :ascii, :highlight, :highlight_direction, :cols

	def initialize options
		@bg = options[:background]
		@hover = options[:hover]
		@fg = options[:foreground]
		@bg = Theme.get(:background).bg if @bg.nil?
		@fg = Theme.get(:textcolor) if @fg.nil?
		@bg2 = @bg if @bg2.nil?
		@ascii = options[:ascii]
		@ascii = true if @ascii.nil?

		@pixel = options[:pixel]
		@pixel = Theme.get(:border) if @pixel.nil?

		@table = options[:table]
		@table = [] if @table.nil?

		@cols = options[:cols]
		@cols = [] if @cols.nil?

		@highlight = options[:highlight]
		@highlight = 0 if @highlight.nil?

		@highlight_direction = options[:highlight_direction]
		@highlight_direction = :horizontal if @highlight_direction.nil?

		@x = options[:x]
		@x = 1 if @x.nil?
		@y = options[:y]
		@y = 1 if @y.nil?

		@reverse = false
		@header = false
		@header = true if options[:header] == true

		@meta = { :height => @table.size, :cols => 0 }
		index_col_widths

		create

		@height = @table.size
		#@height += 2 if @ascii
		@width  = @table[0].size


	end

	##
	# Set data
	def set_table table
		@table = table
		index_col_widths
		create
	end

	##
	# Add line to table
	def add line
		@table << line
		@height += 1
		index_col_widths
		create
	end

	##
	# Delete line from table by index
	def delete line_id
		if !@table[line_id].nil?
			@table.delete_at(line_id)
			@height -= 1
			index_col_widths
			create
		end
	end

	##
	# highlight line
	def highlight line_id
		return highlight if line_id.nil?
		@highlight = line_id
		@reverse = false
		create
	end

	##
	# create or recreate the table object
	def create
		obj = []
		if @header
			obj << ascii_table_line if @ascii
			_obj = []
			_obj << Pixel.new(@pixel.fg,@bg,"|") if @ascii
			@cols.each_with_index do |col, index|
				fg = @pixel.fg
				fg = @cols[index][:title_color] if !@cols[index].nil? and !@cols[index][:title_color].nil?
				chars = "".to_s.split("")
				chars = " #{ col[:title] }".to_s.split("") if !col.nil? and !col[:title].nil?
				chars.each_with_index do |e, char_count|
					_obj << Pixel.new(fg,@bg,e)
				end
				(@meta[:max_widths][index]-chars.size+2).times do |i|
					_obj << Pixel.new(@pixel.fg,@bg," ")
				end
				_obj << Pixel.new(@pixel.fg,@bg,"|") if @ascii
			end
			obj << _obj
		end
		obj << ascii_table_line if @ascii
		@table.each_with_index do |line, lindex|
			bg = @bg
			bg = @hover if lindex == @highlight and @highlight_direction == :horizontal
			_obj = []
			_obj << Pixel.new(@pixel.fg,bg,"|") if @ascii
			line.each_with_index do |col, index|
				fg = @fg
				fg = @cols[index][:color] if !@cols[index].nil? and !@cols[index][:color].nil?

				if @highlight_direction == :vertical
					if index == @highlight
						bg = @hover
					else
						bg = @bg
					end
				end


				chars = col.to_s.split("")
				_obj << Pixel.new(@pixel.fg,bg," ")
				max_chars = nil
				max_chars = @cols[index][:max_length]+1 if !@cols[index].nil? and !@cols[index][:max_length].nil?
				max_chars = @cols[index][:length]+1 if !@cols[index].nil? and !@cols[index][:length].nil?
				chars.each_with_index do |e, char_count|
					break if !max_chars.nil? and char_count >= max_chars
					_obj << Pixel.new(fg,bg,e)
				end
				(@meta[:max_widths][index]-chars.size+1).times do |i|
					_obj << Pixel.new(@pixel.fg,bg," ")
				end

				bg = @bg if @highlight_direction == :vertical
				_obj << Pixel.new(@pixel.fg,bg,"|") if @ascii
			end
			obj << _obj
		end
		obj << ascii_table_line if @ascii
		@obj = obj
	end

	##
	# sort by column
	def sort col
		@table.sort! { |a,b| a[col] <=> b[col] }
		@table.reverse! if @reverse
		if @reverse == false
			@reverse = true
		else
			@reverse = false
		end
		create
	end

	private
	def ascii_table_line
		_obj = []
		_obj << Pixel.new(@pixel.fg,@bg,"+")
		@meta[:max_widths].each do |index,mw|
			(mw+2).times do |i|
				_obj << Pixel.new(@pixel.fg,@bg,"-")
			end
			_obj << Pixel.new(@pixel.fg,@bg,"+")
		end
		_obj
	end

	def index_col_widths
		@meta[:cols] = 0
		@meta[:max_widths] = {}
		@table.each do |line|
			cols = 0
			if !line.nil?
				line.each_with_index do |col, index|
					@meta[:max_widths][index] = col.size if @meta[:max_widths][index].nil?
					@meta[:max_widths][index] = col.size if @meta[:max_widths][index] < col.size
					@meta[:max_widths][index] = @cols[index][:max_length] if !@cols.nil? and !@cols[index].nil? and !@cols[index][:max_length].nil?
					@meta[:max_widths][index] = @cols[index][:length] if !@cols.nil? and !@cols[index].nil? and !@cols[index][:length].nil?
				end
				@meta[:cols] = cols if cols > @meta[:cols]
			end
		end
	end
end
