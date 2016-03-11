require_relative '../test_helper'

class RuTuiTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::RuTui::VERSION
  end
end
