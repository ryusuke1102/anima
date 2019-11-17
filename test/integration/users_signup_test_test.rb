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

  test "valid signup information" do
    #サインアップ成功の動作
    get signup_path
    assert_difference 'User.count',1 do
      post signup_path, params: { name:  "ryusukemine",
                                  email: "ryusuke@gmail.com",
                                  password:              "password"} 
    end
    assert_redirected_to root_path
    assert_not flash.empty?
  end
end
