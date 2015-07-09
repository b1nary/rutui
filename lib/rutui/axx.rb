## Basic Ascii Image format Axx
# First implemented: here :3
#
# Example:
#  # Comments ...
#  nil|A:1:0|A|A:2
#
#  nil 		empty pixel
#	 A:1:0	Char is A, 1 is foreground, 0 is background
#	 A			Char only (colors default)
#	 A:2		Char A, Foreground 2, Background default
#
class Axx < BaseObject
	def initialize options
		@file = options[:file]
		@x = options[:x]
		@y = options[:y]

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

