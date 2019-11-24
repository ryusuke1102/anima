require 'test_helper'

class UsersSignupTestTest < ActionDispatch::IntegrationTest

  test "invalid signup information" do
    #サインアップ失敗の動作
    get signup_path
    assert_no_difference 'User.count' do
      post signup_path, params: { name:  "",
                                  email: "ryusuke@gmail.com",
                                  password:              "mineneeee"} 
    end
    assert_template 'users/new'
  end

  test "valid signup information with account activation" do
    #サインアップ成功の動作
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params: { name:     "Example" ,
                                  email:    "user@example.com",
                                  password: "password"}
     end
    assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.activated?

    get edit_account_activation_path("invalid token", email: user.email)
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: 'wrong')
    assert_not is_logged_in?

    get edit_account_activation_path(user.activation_token, email: user.email)
    assert user.reload.activated?
    assert_redirected_to root_path
    assert_not flash.empty?
    assert is_logged_in?
  end
end
