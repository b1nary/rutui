# This file contains the ScreenManager

## Screen Manager Class
# Static class to handle screens 
#
class ScreenManager
	@@screens = {}
	@@current = :default

	# Set a screen
	#  Ex.: ScreenManager.set :default, Screen.new
	def self.add name, screen
		@@screens[name] = screen
	end

	# Get count of existing screens
	def self.size
		@@screens.size
	end

	# Delete screen by name
	def self.delete name
		@@screens.delete(name) if !@@screens[name].nil?
	end

	# Set current screen
	def self.set_current name
		@@current = name
	end

	# Get current screen
	def self.get_current
		# Fix size and others of screen here
		@@current
	end

	# Get the complete screen by name
	def self.get_screen name
		@@screens[name]
	end

	# Refit screen size
	def self.refit
		size = Utils.winsize
		if @autofit and size != @lastsize
			@@screens[@@current].rescreen
			@lastsize = size
		end
	end

	# draw current screen
	def self.draw
		print Color.clear
		@@screens[@@current].draw
	end

	# Raw Game Loop
	#  Ex.: ScreenManager.loop({ :autodraw => true, :autofit => true }){ |key| p key } 
	def self.loop options
		autodraw = options[:autodraw]
		@autofit = options[:autofit]
		@autofit = true if @autofit.nil?
		@lastsize = nil
		Utils.init
		ScreenManager.draw

		while true
			key = Utils.gets
			yield key
			ScreenManager.refit if @autofit
			ScreenManager.draw if autodraw
		end
	end
end
