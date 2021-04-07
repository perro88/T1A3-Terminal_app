require "test/unit"
require_relative "../classes/user"

class UserTest < Test::Unit::TestCase
  def setup
    @user = User.new("username", "password")
  end

  def test_new_instance
    @user
    assert_not_nil(@user)
  end

  def test_username
    @user
    assert_equal("username", @user.username)
  end

  def test_password
    @user
    assert_equal("password", @user.password)
  end

  def test_user_full_login
    @user
    assert_equal("username password", @user.full_login)
  end

  def test_no_params
    assert_raise do
      @user = User.new
    end
  end
end
