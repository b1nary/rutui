require_relative '../test_helper'

class AnsiTest < Minitest::Test

  def test_ansi_escapes
    assert_equal 10756,         RuTui::Ansi.rgb(255,255,30)
    assert_equal "\e[48;5;5m",  RuTui::Ansi.background(5)
    assert_equal "\e[38;5;5m",  RuTui::Ansi.foreground(5)
    assert_equal "\e[48;5;11m", RuTui::Ansi.bg(11)
    assert_equal "\e[38;5;11m", RuTui::Ansi.fg(11)
    assert_equal "\e[1m",       RuTui::Ansi.bold
    assert_equal "\e[2m",       RuTui::Ansi.thin
    assert_equal "\e[3m",       RuTui::Ansi.italic
    assert_equal "\e[4m",       RuTui::Ansi.underline
    assert_equal "\e[5m",       RuTui::Ansi.blink
    assert_equal "\e[0m",       RuTui::Ansi.clear_color
    assert_equal "\e[2J",       RuTui::Ansi.clear
    assert_equal "\e[s",        RuTui::Ansi.set_start
    assert_equal "\e[u",        RuTui::Ansi.goto_start
    assert_equal "\e[H",        RuTui::Ansi.go_home
    assert_equal "\e[2;1f",     RuTui::Ansi.position(1,2)
    assert_equal "\e?25l",      RuTui::Ansi.hide_cursor
  end

end
