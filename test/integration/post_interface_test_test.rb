require 'test_helper'

class PostInterfaceTestTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:minee)
  end

  test "post interface "do
    get login_path
    post login_path, params: { email:@user.email,
                               password:@user.password} 
  #Post失敗
    assert_no_difference "Post.count" do
      post posts_create_path, params: { content: ""}
    end
  #Post成功
    assert_difference "Post.count",1 do 
      post posts_create_path, params: { content: "content",
                                        detail: "detail"}
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_not flash.empty?
  #Post削除
    @post = @user.posts.first
    assert_difference "Post.count", -1 do
      delete post_path(@post)
    end
    assert_redirected_to posts_path
    follow_redirect!
    assert_not flash.empty?
  #違うユーザーのプロフィールページのリンクの有無
    get edit_user_path(users(:ryusuke))
    assert_select "a[href=?]", post_path(@post), count:0
  end
end
