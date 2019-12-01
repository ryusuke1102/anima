require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest


  def setup
    @post  = posts(:cat)
    @post2 = posts(:snake)
    @user  = users(:minee)
  end

  test "should redirect create when not logged in" do
    #非ログイン状態でのPost投稿時のリダイレクト
    assert_no_difference "Post.count" do
      post posts_create_path, params: { content: "test content"}
    end
      assert_redirected_to login_path
      follow_redirect!  
      assert_not flash.empty?
  end

  test "should redirect destroy when not logged in" do
    #非ログイン状態でのPost削除時のリダイレクト
    assert_no_difference "Post.count" do
      delete post_path(@post)
    end
      assert_redirected_to login_path
      follow_redirect!
      assert_not flash.empty?
  end

  test "should redirect destroy for wrong posts" do
    #他のユーザーのPost削除時の動作
    get login_path
    post login_path, params: { email:@user.email,
                               password:@user.password} 
    assert_no_difference "Post.count" do
      delete post_path(@post2)
    end
    assert_redirected_to root_path
  end

end
