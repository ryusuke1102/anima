require 'test_helper'

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get root" do
    get root_url
    assert_response :success
    assert_select "title", "Top | Anima"
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


  test "should not get index" do
    get users_path
    assert_response :redirect
    assert_redirected_to login_path
  end

end
