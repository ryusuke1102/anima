require 'test_helper'

class PostTest < ActiveSupport::TestCase
 
  def setup
    @user = users(:minee)
    @post = @user.posts.build(content: "countents", detail: "details")
  end

  test "should valid post" do
    assert @post.valid?
  end

  test "user id should be present" do
    @post.user_id  = nil
    assert_not @post.valid?
  end

  test "content should be present" do
    @post.content  = ""
    assert_not @post.valid?
  end

  test "detail should be present" do
    @post.detail   = ""
    assert_not @post.valid?
  end

  test "content should not be too long" do
    @post.content  = "a" * 31
    assert_not @post.valid?
  end

  test "detail should not be too long" do
    @post.detail   = "a" * 351
    assert_not @post.valid?
  end

end