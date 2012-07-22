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

