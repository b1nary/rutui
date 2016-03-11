require_relative '../test_helper'

class PixelTest < Minitest::Test
  def test_can_create_custom_pixel
    pixel = RuTui::Pixel.new(10, 3, "-")
    assert_equal 10, pixel.foreground
    assert_equal 3, pixel.background
    assert_equal "-", pixel.symbol
  end

  def test_random_pixel_takes_optional_custom_symbol
    pixel = RuTui::Pixel.random("!")
    assert_equal "!", pixel.symbol
    assert !pixel.foreground.nil?
    assert !pixel.background.nil?
  end

  def test_supports_fg_and_bg_shortcuts
    pixel = RuTui::Pixel.new(10, 3, "-")
    assert_equal 10, pixel.fg
    assert_equal 3, pixel.bg
  end

  def test_can_change_pixel_trough_attr_accessor
    pixel = RuTui::Pixel.new(10, 10, "-")
    pixel.background = 1
    pixel.foreground = 1
    pixel.symbol = "#"

    assert_equal 1, pixel.background
    assert_equal 1, pixel.foreground
    assert_equal "#", pixel.symbol
  end

  def test_longer_pixel_text_gets_cut_away
    pixel = RuTui::Pixel.new(10, 10, "test")
    assert_equal "t", pixel.symbol
  end

  def test_symbol_can_be_nil
    pixel = RuTui::Pixel.new(10, 10, nil)
    assert_equal nil, pixel.symbol
  end

  def test_get_pixel_hash
    pixel = RuTui::Pixel.new(10, 10, "~")
    assert_equal({:background=>10, :foreground=>10, :symbol=>"~"}, pixel.to_h)
  end

  # pixel extras
  def test_pixel_can_be_bold
    pixel = RuTui::Pixel.new(10, 10, "~", bold: true)
    assert_equal({background: 10, foreground: 10, symbol: "~", bold: true}, pixel.to_h)
  end

  def test_pixel_can_be_thin
    pixel = RuTui::Pixel.new(10, 10, "~", thin: true)
    assert_equal({background: 10, foreground: 10, symbol: "~", thin: true}, pixel.to_h)
  end

  def test_pixel_can_be_italic
    pixel = RuTui::Pixel.new(10, 10, "~", italic: true)
    assert_equal({background: 10, foreground: 10, symbol: "~", italic: true}, pixel.to_h)
  end

  def test_pixel_can_be_underline
    pixel = RuTui::Pixel.new(10, 10, "~", underline: true)
    assert_equal({background: 10, foreground: 10, symbol: "~", underline: true}, pixel.to_h)
  end

  def test_pixel_can_be_blink
    pixel = RuTui::Pixel.new(10, 10, "~", blink: true)
    assert_equal({background: 10, foreground: 10, symbol: "~", blink: true}, pixel.to_h)
  end
end
