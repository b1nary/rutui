module RuTui
  # Axx Parser
  #
  # Axx is our custom image format. The gem needed something flexible but mighty to present
  # "images" or static objects in a portable file format.
  #
  # I dont know why i called it Axx, but thats its name now
  class Axx
    # parse axx string to object format
    #
    # @param image [String] axx object string
    # @return [Array] returns object as array
    def self.parse image
      out = []
      image.split("\n").each_with_index do |line, line_count|
        if !line.match(/^#/)
          out[line_count] = []
          line.split("|").each_with_index do |column, column_count|
            value = column.split(":")
            if value.size == 3
              out[line_count][column_count] = Pixel.new(value[1].to_i, value[2].to_i, value[0])
            elsif value.size == 2
              out[line_count][column_count] = Pixel.new(value[1].to_i, nil, value[0])
            elsif value[0] == "nil"
              out[line_count][column_count] = nil
            else
              out[line_count][column_count] = Pixel.new(nil,nil,value[0])
            end
          end
        end
      end

      out.compact
    end

  end
end
