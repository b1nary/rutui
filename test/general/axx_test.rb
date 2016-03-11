require_relative '../test_helper'

class AxxTest < Minitest::Test
  def test_can_parse_simple_axx
    axx = RuTui::Axx.parse("A:1:1|B:2:2\nC:3:3|D:4:4")
    assert_equal({:background=>1, :foreground=>1, :symbol=>"A"}, axx.first.first.to_h)
  end

  def test_can_parse_empty_pixel
    axx = RuTui::Axx.parse("nil|B:2:2\nC:3:3|D:4:4")
    assert_equal(nil, axx.first.first)
  end

  def test_can_parse_text_color_only
    axx = RuTui::Axx.parse("A:1|B:2:2\nC:3:3|D:4:4")
    assert_equal({:background=>nil, :foreground=>1, :symbol=>"A"}, axx.first.first.to_h)
  end

  def test_can_parse_utf8
    axx = RuTui::Axx.parse("♥:1|B:2:2\nC:3:3|D:4:4")
    assert_equal({:background=>nil, :foreground=>1, :symbol=>"♥"}, axx.first.first.to_h)
  end

  def test_parser_removes_empty_lines
    axx = RuTui::Axx.parse("A:1|B:2:2\n\n\n\n")
    assert_equal 1, axx.size
  end
end
