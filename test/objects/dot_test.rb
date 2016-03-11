require_relative '../test_helper'

class DotTest < Minitest::Test

  def test_create_new_dot_without_options
    dot = RuTui::Dot.new()
    assert_dot dot, 11, nil, " "
  end

  def test_create_new_dot_with_options
    dot = RuTui::Dot.new(foreground: 2, background: 3, symbol: "s")
    assert_dot dot, 2, 3, "s"
  end

  def test_changing_values_directly_recreates_the_object
    dot = RuTui::Dot.new(foreground: 2, background: 3, symbol: "s")
    dot.foreground = 4
    assert_dot dot, 4, 3, "s"
    dot.background = 2
    assert_dot dot, 4, 2, "s"
    dot.symbol = "$"
    assert_dot dot, 4, 2, "$"
  end

  def assert_dot dot, foreground, background, symbol
    assert_equal foreground, dot.foreground
    assert_equal background, dot.background
    assert_equal symbol, dot.symbol

    assert_equal foreground, dot.object.first.first.foreground
    assert_equal background, dot.object.first.first.background
    assert_equal symbol, dot.object.first.first.symbol
  end

end
