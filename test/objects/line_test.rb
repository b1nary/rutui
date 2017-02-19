require_relative '../test_helper'

class LineTest < Minitest::Test

  def test_create_new_line_without_options_raises
    assert_raises RuntimeError do
      dot = RuTui::Line.new()
    end
  end

  def test_create_new_line_with_options
    line = RuTui::Line.new(length: 12, orientation: :vertical)
    assert_equal 12, line.length
    assert_equal :vertical, line.orientation
  end

  def test_create_new_line_defaults_to_horizontal
    line = RuTui::Line.new(length: 12)
    assert_equal :horizontal, line.orientation
  end

  def test_creates_right_line_object
    assert_equal([
      {
        background: nil,
        foreground: 11,
        symbol: " "
      },
      {
        background: nil,
        foreground: 11,
        symbol: " "
      }
    ], create_line(length: 2))
  end

  def test_creates_bordered_horizontal_line_object
    assert_equal([
      {
        background: nil,
        foreground: 11,
        symbol: "─"
      }
    ], create_line(length: 1, border: true))
  end

  def test_creates_bordered_vertical_line_object
    assert_equal([
      {
        background: nil,
        foreground: 11,
        symbol: "│"
      }
    ], create_line(length: 1, border: true, orientation: :vertical))
  end

  def create_line(*args)
    RuTui::Line.new(*args).object.map{|l| l.map(&:to_h) }.flatten
  end
end
