require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
 
  def setup
    @user  = users(:minee)
    @other = users(:ryusuke)
  end
 

  #非ログイン時のフォロー
  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_path
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_path
  end

end
