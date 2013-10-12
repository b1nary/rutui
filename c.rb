require 'rutui'

255.times do |i|
	print "#{RuTui::Color.fg(i)}#{i}\t"
end
