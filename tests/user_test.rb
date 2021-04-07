require "test/unit"
require_relative "../classes/user"

class UserTest < Test::Unit::TestCase
  def test_new_instance
    user = User.new("usename", "password")
    assert_not_nil(user)
  end
end
