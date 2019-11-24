require 'test_helper'

class UserActivationTestTest < ActionDispatch::IntegrationTest

  def setup
    @user  = users(:minee)    #認証済みユーザー
    @user2 = users(:ryusuke)  #非認証ユーザー
  end

  test "user index only correct link" do
    get login_path
    post login_path, params: { email:@user.email,
                               password:@user.password}                            
    get users_path
    assert_select "a[href=?]", edit_user_path(@user)
    assert_select "a[href=?]", edit_user_path(@user2), count: 0
  #認証済みユーザーのリンク
    get edit_user_path(@user)
    assert_template 'users/edit'
  #認証されてないユーザーのリンク
    get edit_user_path(@user2)
    assert_redirected_to root_path
  end
end
