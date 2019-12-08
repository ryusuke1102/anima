require 'test_helper'

class UsersIndexTest < ActionDispatch::IntegrationTest
  
  def setup
    @user  = users(:minee)
    @user2 = users(:dog)
    
  end
 
  test "index correct link" do
    log_in_as(@user)
    get users_path
    assert_template 'users/index'
    assert_select 'div.pagenation'
    assert_select 'div.search'
    assert_select 'a[href=?]', edit_user_path(@user), text: @user.name
  end

  test "user search" do
    log_in_as(@user)
    # 検索未使用
    get users_path, params: {q: {name_cont: ""}}
    assert_select 'a[href=?]', edit_user_path(@user), text:@user.name, count: 2
    assert_select 'a[href=?]', edit_user_path(@user2), text:@user2.name

    # @userを検索
    get users_path, params: {q: {name_cont: "minee"}}
    q = User.ransack(name_cont: "minee", activated_true: true)
    assert_select 'a[href=?]', edit_user_path(@user), text:@user.name, count: 2
    assert_select 'a[href=?]', edit_user_path(@user2), text:@user2.name, count: 0

     # 存在しないユーザーを検索
    get users_path, params: {q: {name_cont: "detarame"}}
    assert_select 'a[href=?]', edit_user_path(@user), text:@user.name, count: 1
    assert_select 'a[href=?]', edit_user_path(@user2), text:@user2.name, count: 0
    assert_match  "該当ユーザーが見つかりません", response.body
    end 
end
