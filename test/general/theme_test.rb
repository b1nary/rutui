require_relative '../test_helper'

class ThemeTest < Minitest::Test
  def test_uses_default_theme_by_default
    assert_equal :default, RuTui::Theme.class_eval("@@default")
  end

  def test_switching_theme_switches_the_theme
    RuTui::Theme.new(:light, {}, true)
    assert_equal :light, RuTui::Theme.class_eval("@@default")

    RuTui::Theme.default :default # reset
  end

  def test_unknown_default_theme_raises
    assert_raises RuntimeError do
      RuTui::Theme.default :unknown
    end
  end

  def test_create_new_theme_merges_default_theme_options
    RuTui::Theme.new(:light, {test: true}, true)
    theme = RuTui::Theme.new(:test, {})
    assert theme.get(:test)

    RuTui::Theme.default :default # reset
  end

  def test_can_get_default_theme_values
    RuTui::Theme.new(:light, {test: true}, true)
    assert RuTui::Theme.get(:test)

    RuTui::Theme.default :default # reset
  end

  def test_can_get_default_theme
    assert_equal :default, RuTui::Theme.default
  end

  def test_can_set_theme_instance_value
    theme = RuTui::Theme.new(:light, {}, true)
    theme.set(:test, true)
    assert RuTui::Theme.get(:test)

    RuTui::Theme.default :default # reset
  end

  def test_can_get_a_formerly_created_theme_by_name
    RuTui::Theme.new(:test, {test: true})
    assert RuTui::Theme.get_theme(:test).get(:test)
  end

  def test_get_theme_hash_for_default_theme
    assert_equal({background: nil, foreground: 11, symbol: " "},
                 RuTui::Theme.to_h[:foreground].to_h)
  end

  def test_get_theme_hash_for_theme
    assert_equal({background: nil, foreground: 11, symbol: " "},
                 RuTui::Theme.new(:test, {}).to_h[:foreground].to_h)
  end
end
