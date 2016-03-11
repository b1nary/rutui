require_relative '../test_helper'

class BaseObjectTest < Minitest::Test

  def test_base_object_parses_basic_options_without_object
    obj = RuTui::BaseObject.new({ x: 10, y: 5, width: 2, height: 3 })

    assert_equal 10, obj.x
    assert_equal 5, obj.y
    assert_equal 2, obj.width
    assert_equal 3, obj.height
    assert_equal [[nil,nil],[nil,nil],[nil,nil]], obj.object
  end

  def test_base_object_parses_basic_options_without_object
    obj = create_basic_object

    assert_equal 1, obj.x
    assert_equal 1, obj.y
    assert_equal 2, obj.width
    assert_equal 2, obj.height
    assert_equal [[nil,nil],[nil,nil]], obj.object
  end

  def test_move_object
    obj = create_basic_object
    obj.move 2,5

    assert_equal 3, obj.x
    assert_equal 6, obj.y

    obj.move -2,-4

    assert_equal 1, obj.x
    assert_equal 2, obj.y
  end

  def test_set_position
    obj = create_basic_object
    obj.set_position 2, 5

    assert_equal 2, obj.x
    assert_equal 5, obj.y
  end

  def test_set_and_get_pixel
    obj = create_basic_object
    obj.set_pixel(1,1, RuTui::Pixel.new(222,222,"-").to_h)
    assert_equal RuTui::Pixel.new(222,222,"-").to_h, obj.get_pixel(1, 1)
  end

  def test_object_each
    obj = create_basic_object
    items = 0
    obj.each do |x, y, pixel|
      assert (x == 0 || x == 1)
      assert (y == 0 || y == 1)
      assert_equal nil, pixel
      items += 1
    end
    assert_equal 4, items
  end

  def test_uses_default_theme_by_default
    obj = create_basic_object
    assert_equal RuTui::Theme, obj.theme
  end

  def test_can_set_theme
    test_theme = RuTui::Theme.new(:test)
    obj = create_basic_object({ theme: test_theme })
    assert_equal test_theme, obj.theme
  end

  def test_create_new_theme_when_true
    obj = create_basic_object({ theme: true })
    assert obj.theme.instance_of? RuTui::Theme
  end

  def test_create_theme_on_the_fly_with_values
    obj = create_basic_object({ theme: {test: true} })
    assert obj.theme.get(:test)
  end

  def create_basic_object options = {}
    RuTui::BaseObject.new({ object: [[nil,nil],[nil,nil]] }.merge(options))
  end

end
