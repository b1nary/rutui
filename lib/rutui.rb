#!/usr/bin/env ruby
# encoding: UTF-8
#
# https://github.com/b1nary/rutui
#
# Author: Roman Pramberger (roman@pramberger.ch)
# License: MIT
#
require 'rutui/util'
require 'rutui/pixel'
require 'rutui/theme'
require 'rutui/objects'
require 'rutui/screen'
require 'rutui/screenmanager'
require 'rutui/figlet'
require 'rutui/axx'
require 'rutui/sprites'
require 'rutui/table'
require 'rutui/textfield'
require 'rutui/checkbox'

$escape = "\x1b"
$escape = "\033" if RUBY_PLATFORM =~ /(win32|w32)/

#if RUBY_PLATFORM =~ /(win32|w32)/
#	begin
#		require 'rubygems'
#		require 'win32console'
#		include Win32::Console::ANSI
#		include Term::ANSIColor
#	rescue
#		puts "You need the win32console gem for ansi/color support"
#	end
#end

module RuTui
	Ansi 	= ::Ansi
	Utils 	= ::Utils
	Pixel 	= ::Pixel
	Theme 	= ::Theme
	BaseObject = ::BaseObject
	Box 	= ::Box
	Line 	= ::Line
	Circle 	= ::Circle
	Text 	= ::Text
	Screen 	= ::Screen
	ScreenManager = ::ScreenManager
	Figlet 	= ::Figlet
	Axx 	= ::Axx
	Sprite 	= ::Sprite
	Table 	= ::Table
	Textfield = ::Textfield
	Checkbox = ::Checkbox
end
