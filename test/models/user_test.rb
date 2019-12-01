require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  def setup 
    @user = User.new(name: "minee", email: "minee@example.com", password: "111111")
    @other = User.new(name: "", email: "other@example.com", password: "password")
    @other2 = User.new(name: "minee", email: "", password: "minee")
    @other3 = User.new(name: "minee", email: "other3@example.com", password: "")

  end

  test "should be valid user" do
    assert @user.valid?
    end

  test "should not be valid user" do
    assert_not @other.valid?
    assert_not @other2.valid?
    assert_not @other3.valid?
  end

  test "name should not be too long" do
    @user.name = "a" * 51
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = " "*6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = "a" *4
    assert_not @user.valid?
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com] 
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    same_user = @user.dup
    same_user.email = @user.email.upcase
     @user.save
    assert_not same_user.valid?
  end

  test "email addresses should be saved as lower-case" do
    mixed_case_email = "MiNee@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "should follow and unfollow a user" do
    #フォローのテスト
    minee   = users(:minee)
    dog = users(:dog)
    assert_not minee.following?(dog)
    minee.follow(dog)
    assert minee.following?(dog)
    assert dog.followers.include?(minee)
    minee.unfollow(dog)
    assert_not minee.following?(dog)
  end

  test "feed should have the right posts" do
    minee = users(:minee)
    dog   = users(:dog)
    cat   = users(:cat)
    #フォローしているユーザーの投稿を表示
    cat.posts.each do |p|
      assert minee.feed.include?(p)
    end
    #自分自身の投稿を表示
    minee.posts.each do |p|
      assert minee.feed.include?(p)
    end
    #フォローしていないユーザーの投稿を非表示
    dog.posts.each do |p|
      assert_not minee.feed.include?(p)
    end

  end
end
