require 'test_helper'

class UsersLoginTestTest < ActionDispatch::IntegrationTest
 
  def setup
    @user = users(:minee)
  end
 
  test "login with valid information" do
  #ログインの動作
    get login_path
    post login_path, params: { email:@user.email,
                               password:@user.password} 
    assert_redirected_to posts_path
    follow_redirect!
    assert_template 'posts/index'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", logout_path 
    assert_select "a[href=?]", posts_path 
    assert_select "a[href=?]", posts_new_path 
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", login_path, count: 0

  #ログアウトの動作
    post logout_path
    assert_redirected_to login_path
    follow_redirect!
    assert_template 'users/login_form'
    assert_select "a[href=?]", root_path
    assert_select "a[href=?]", posts_path
    assert_select "a[href=?]", signup_path
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path, count: 0
    assert_select "a[href=?]", posts_new_path, count: 0
    assert_select "a[href=?]", users_path, count:0

    end

  
end
