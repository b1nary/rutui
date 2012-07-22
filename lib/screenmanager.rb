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

	# draw current screen
	def self.draw
		print Color.clear
		@@screens[@@current].draw
	end

	# Raw Game Loop
	#  Ex.: ScreenManager.loop({ autodraw => true }){ |key| p key } 
	def self.loop options
		autodraw = options[:autodraw]
		Utils.init
		ScreenManager.draw

		while true
			key = Utils.gets
			yield key
			ScreenManager.draw if autodraw
		end
	end
end
