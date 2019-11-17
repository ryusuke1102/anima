require 'test_helper'

class UserUpdateTestTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:minee)
  end

  test "user update and destroy link test" do
    #ユーザー詳細画面のリンク
      get login_path
      post login_path, params: { email: @user.email,
                                 password: @user.password}
      get  edit_user_path(@user)
      assert_template 'users/edit'
      assert_select "a[href=?]", users_path(users)
      assert_select "a[href=?]", user_path(@user)

    #ユーザー情報の更新
      get user_path(@user)
      patch user_path(@user), params: { name:"minee",
                                        email:"mineeee@gmail.com",
                                        password:"ryusuke"} 
      assert_redirected_to edit_user_path(@user)
      assert_not flash.empty?
    end

  test "delete user test" do
    #ユーザーの削除
      get login_path
      post login_path, params: { email:@user.email,
                                 password:@user.password} 
      assert_redirected_to posts_path
      follow_redirect!
      assert_template 'posts/index'
      assert_difference 'User.count',-1 do
        delete user_path(@user)
      end
      assert_redirected_to root_path
      assert_not flash.empty?
  
    end    
end
