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
