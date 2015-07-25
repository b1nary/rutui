#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'rutui'

255.times do |i|
	print "#{RuTui::Ansi.fg(i)}#{i}\t"
end

print RuTui::Ansi.clear_color
