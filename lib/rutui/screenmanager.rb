# This file contains the ScreenManager
module RuTui
	## Screen Manager Class
	# Static class to handle screens
	#
	class ScreenManager
		@@screens = {}
		@@current = :default
		@@blocked = false

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
			size = Screen.size
			if @autofit and size != @lastsize
				@@screens[@@current].rescreen
				@lastsize = size
			end
		end

		# draw current screen
		def self.draw
			print RuTui::Ansi.go_home
			@@screens[@@current].draw
		end

		# Raw Game Loop
		#  Ex.: ScreenManager.loop({ :autodraw => true, :autofit => true }){ |key| p key }
		def self.loop options
			autodraw = options[:autodraw]
			@autofit = options[:autofit]
			@autofit = true if @autofit.nil?
			@timeout = options[:timeout]
			@lastsize = nil
			@lastaction = Time.now.to_f
			print RuTui::Ansi.clear
			print RuTui::Ansi.set_start
			Screen.hide_cursor

			ScreenManager.draw

			while true
				if !@@blocked
					@@blocked = true
					key = Screen.gets
					yield key
					if (@timeout.nil? or (@lastaction < Time.now.to_f-@timeout))
						@lastaction = Time.now.to_f
						ScreenManager.refit if @autofit
						ScreenManager.draw if autodraw
					end
					@@blocked = false
				end
			end

		end
	end
end
