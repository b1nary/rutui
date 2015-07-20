# encoding: UTF-8
module RuTui
	## Figlet Class
	# parse Figlet Font files
	#
	# Attributes (All accessable):
	#	 :x		MUST
	#	 :y		MUST
	#	 :text		Your text
	#	 :font		Use a loaded font file
	#	 :rainbow	true|any
	#	 :colors	Array of example pixels used for colors
	#
	#
	# Example:
	#	 Figlet.add :test, "path/to/font.flf"
	#	 Figlet.new({ :text => "Meh", :font => :test, :rainbow => true })
	#
	# Config content (just to remember what the figlet slug means)
	#	 0   - name
	#	 1   - height of a character
	#	 2   - height of a character, not including descenders
	#	 3   - max line length (excluding comment lines) + a fudge factor
	#	 4   - default smushmode for this font (like "-m 0" on command line)
	#	 5   - number of comment lines
	#	 6   - rtol
	#
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
			@colors = [Pixel.new(Theme.get(:textcolor), -1, Theme.get(:background).symbol)] if @colors.nil?

			create
		end

		# Create Figlet text object
		# Recall it any time when attributes have changed
		def create
			obj = []
			@@fonts[@font]['n'].size.times do
				obj << []
			end
			current = 0

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
									obj[ri] << Pixel.new(@@rainbow[current], @colors[0].bg,Theme.get(:background).symbol)
								else
									obj[ri] << Pixel.new(@colors[current].fg,@colors[current].bg,Theme.get(:background).symbol)
								end
							end
						end
					end
				# SPace
				else
					@@fonts[@font]['n'].size.times do |ri|
						3.times do
							if @rainbow
								obj[ri] << Pixel.new(@@rainbow[current], @colors[0].bg, Theme.get(:background).symbol)
							else
								obj[ri] << Pixel.new(@colors[current].fg,@colors[current].bg, Theme.get(:background).symbol)
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
				data.delete_at(0)

				# Remove empty line if exist
				data.delete_at(0) if data[0].strip() == ""

				height = config[1].to_i
				rest = height - config[2].to_i

				@@fonts[name] = {}

				@@chars.each do |i|
					out = []

					config[2].to_i.times do |x|
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
end
