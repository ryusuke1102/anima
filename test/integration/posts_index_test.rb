require 'test_helper'

class PostsIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user  = users(:minee)
    @post  = posts(:cat)
    @post2 = posts(:dog)
    log_in_as(@user)

  end

  test "posts index page" do
    get posts_path 
    assert_template 'posts/index'
    assert_select 'div.pagenation'
    assert_select 'div.search'
    assert_match @post.content, response.body
    assert_select 'a[href=?]', post_path(@post)
  end
  
  test "posts search" do
    # 検索未使用
    get posts_path, params: {q: {content_cont: ""}}
    assert_select 'a[href=?]', post_path(@post)
    assert_select 'a[href=?]', post_path(@post2)

    # @postを検索
    get posts_path, params: {q: {content_cont: "cat"}}
    q = Post.ransack(name_cont: "cat")
    assert_select 'a[href=?]', post_path(@post)
    assert_select 'a[href=?]', post_path(@post2), count: 0

     # 存在しない投稿を検索
    get posts_path, params: {q: {content_cont: "detarame"}}
    assert_select 'a[href=?]', post_path(@post), count: 0
    assert_select 'a[href=?]', post_path(@post2), count: 0
    assert_match  "該当の投稿はありません", response.body
  end
end
