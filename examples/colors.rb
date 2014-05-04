require 'rutui'

255.times do |i|
	print "#{RuTui::Ansi.fg(i)}#{i}\t"
end
