module RuTui
	## Ascii "images"
	#
	# Create image objects in our Axx format.
	# From :file or :image (string)
	class Image < BaseObject
		# Create a new image/object from axx
		#
		# @param [Hash] options use one of both to create a image
		# @option options [String] :file .axx file path
		# @option options [String] :image .axx in string format
		#
		# @example
		#   Image.new(x: 4, y: 2, file: "path/to/file.axx")
		#   Image.new(x: 4, y: 2, image: "A:1:1|B:2:2\nC:3:3|nil")
		def initialize options
			if options[:file]
				file = options[:file]
				if !File.exists? file
					raise "No image at: #{file}"
				end
				@object = Axx.parse(File.read(file))
			else
				@object = Axx.parse(options[:image])
			end

			super(options)
		end
	end
end
