#!/usr/bin/env ruby

lib_dir = File.dirname(__FILE__) + '/../lib'
$LOAD_PATH.unshift(lib_dir) unless $LOAD_PATH.include?(lib_dir)

require 'rutui'

res_dir = File.dirname(__FILE__) + "/res/"
RuTui::Figlet.add :test_font, res_dir + "colossal.flf"

screen = RuTui::Screen.new
screen.add_static RuTui::Axx.new({ :x => 3, :y => 2, :file => res_dir + 'space-invader.axx' })
screen.add_static RuTui::Figlet.new({ :y => 2, :x => 18, :font => :test_font, :text => 'RuTui' })
screen.draw

print RuTui::Ansi.clear_color + RuTui::Ansi.clear
