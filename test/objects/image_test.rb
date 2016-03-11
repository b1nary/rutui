require_relative '../test_helper'

class ImageTest < Minitest::Test

  def test_can_create_image_from_string
    image = RuTui::Image.new(x: 5, y: 6, image: "nil|A:2:2\nnil|B:2:2")

    assert_equal 2, image.width
    assert_equal 2, image.height
    assert_equal 5, image.x
    assert_equal 6, image.y
    assert_equal({:background=>2, :foreground=>2, :symbol=>"A"}, image.object.first.last.to_h)
  end

  def test_can_create_image_from_file
    image = RuTui::Image.new(x: 2, y: 3, file: "test/files/test.axx")

    assert_equal 2, image.width
    assert_equal 2, image.height
    assert_equal 2, image.x
    assert_equal 3, image.y
    assert_equal({:background=>10, :foreground=>0, :symbol=>" "}, image.object.first.last.to_h)
  end

end
