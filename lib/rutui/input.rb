module RuTui
  ## Input class
  # read and interpret keyboard input
  class Input
    def self.init
      # Look for the current terminal in the hash of terminal scancodes and
      # contruct a scancode -> key symbol lookup  hash. This hash will we used
      # by self.getc to translate the received key presses to symbols.
      @@scancodes.keys.each { |term|
        # Match the terminal name as regexp to get variants,
        #  e.g. xterm matches xterm-256color, too.
        if /#{term}/.match(ENV["TERM"])
          @@keys = Hash[@@scancodes[term].zip @@key_symbols]
          break
        end
      }

      # Special keys are currently not supported on Windows
      # That needs some investigation
      if RUBY_PLATFORM =~ /(win32|w32)/
        @@keys = {}
      end

      # Exit with failure if the terminal was not found
      unless defined? @@keys
        STDERR.puts "Unsupported terminal '#{ENV['TERM']}'."
        exit 1
      end

      # Add the common control key definitions
      @@keys.merge!(@@control_keys)
    end

    # Get input char without enter
    def self.getc
      begin
        IO.console.raw!
        key = IO.console.getch

        if key == "\e"
          begin
            char = IO.console.getch(min: 0, time: 0)
            key += char unless char.nil?
          end until char.nil?
        end

      ensure
        IO.console.cooked!
      end

      # look up special keys
      if @@keys.has_key? key
        return @@keys[key]
      else
        return key
      end
    end

    private
    @@key_symbols = [
      :f1,
      :f2,
      :f3,
      :f4,
      :f5,
      :f6,
      :f7,
      :f8,
      :f9,
      :f10,
      :f11,
      :f12,
      :insert,
      :delete,
      :home,
      :end,
      :pgup,
      :pgdn,
      :up,
      :down,
      :left,
      :right,
    ]

    # Keyboard scancodes for some terminals.
    # The order of keys must match the key symbols above.
    @@scancodes = {
      "linux" => [
        "\e[[A",    # F1
        "\e[[B",    # F2
        "\e[[C",    # F3
        "\e[[D",    # F4
        "\e[[E",    # F5
        "\e[17~",   # F6
        "\e[18~",   # F7
        "\e[19~",   # F8
        "\e[20~",   # F9
        "\e[21~",   # F10
        "\e[23~",   # F11
        "\e[24~",   # F12
        "\e[2~",    # ins
        "\e[3~",    # del
        "\e[1~",    # home
        "\e[4~",    # end
        "\e[5~",    # page up
        "\e[6~",    # page down
        "\e[A",     # up
        "\e[B",     # down
        "\e[D",     # left
        "\e[C",     # right
      ],
      "Eterm" => [
        "\e[11~",   # F1
        "\e[12~",   # F2
        "\e[13~",   # F3
        "\e[14~",   # F4
        "\e[15~",   # F5
        "\e[17~",   # F6
        "\e[18~",   # F7
        "\e[19~",   # F8
        "\e[20~",   # F9
        "\e[21~",   # F10
        "\e[23~",   # F11
        "\e[24~",   # F12
        "\e[2~",    # ins
        "\e[3~",    # del
        "\e[7~",    # home
        "\e[8~",    # end
        "\e[5~",    # page up
        "\e[6~",    # page down
        "\e[A",     # arrow up
        "\e[B",     # arrow down
        "\e[D",     # arrow left
        "\e[C",     # arrow right
      ],
      "rxvt" => [
        "\e[11~",   # F1
        "\e[12~",   # F2
        "\e[13~",   # F3
        "\e[14~",   # F4
        "\e[15~",   # F5
        "\e[17~",   # F6
        "\e[18~",   # F7
        "\e[19~",   # F8
        "\e[20~",   # F9
        "\e[21~",   # F10
        "\e[23~",   # F11
        "\e[24~",   # F12
        "\e[2~",    # ins
        "\e[3~",    # del
        "\e[7~",    # home
        "\e[8~",    # end
        "\e[5~",    # page up
        "\e[6~",    # page down
        "\e[A",     # up
        "\e[B",     # down
        "\e[D",     # left
        "\e[C",     # right
      ],
      "xterm" => [
        "\eOP",     # F1
        "\eOQ",     # F2
        "\eOR",     # F3
        "\eOS",     # F4
        "\e[15~",   # F5
        "\e[17~",   # F6
        "\e[18~",   # F7
        "\e[19~",   # F8
        "\e[20~",   # F9
        "\e[21~",   # F10
        "\e[23~",   # F11
        "\e[24~",   # F12
        "\e[2~",    # ins
        "\e[3~",    # del
        "\e[H",     # home
        "\e[F",     # end
        "\e[5~",    # page up
        "\e[6~",    # page down
        "\e[A",     # up
        "\e[B",     # down
        "\e[D",     # left
        "\e[C",     # right
      ]
    }

    @@control_keys = {
      "\x01" => :ctrl_a,
      "\x02" => :ctrl_b,
      "\x03" => :ctrl_c,
      "\x04" => :ctrl_d,
      "\x05" => :ctrl_e,
      "\x06" => :ctrl_f,
      "\a"   => :ctrl_g,
      "\b"   => :ctrl_h,
      "\t"   => :tab,   # aka CTRL+I
      "\n"   => :ctrl_n,
      "\v"   => :ctrl_k,
      "\f"   => :ctrl_l,
      "\r"   => :enter, # aka CTRL+M
      "\x0e" => :ctrl_n,
      "\x0f" => :ctrl_o,
      "\x10" => :ctrl_p,
      "\x11" => :ctrl_q,
      "\x12" => :ctrl_r,
      "\x13" => :ctrl_s,
      "\x14" => :ctrl_t,
      "\x15" => :ctrl_u,
      "\x16" => :ctrl_v,
      "\x17" => :ctrl_w,
      "\x18" => :ctrl_x,
      "\x19" => :ctrl_y,
      "\x1a" => :ctrl_z,
      "\e"   => :esc,
      "\x7f" => :backspace
    }
  end
end

RuTui::Input.init
