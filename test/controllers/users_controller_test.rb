require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get users_path
    assert_response :success
    assert_select "title", "users-index | Anima"
  end

  test "should get login" do
    get login_path
    assert_response :success
    assert_select "title", "login-form | Anima"
  end

  test "should get new" do
    get signup_path
    assert_response :success
    assert_select "title", "users-new | Anima"
  end



end
