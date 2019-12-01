require 'test_helper'

class UserProfileTestTest < ActionDispatch::IntegrationTest
  include ApplicationHelper

  def setup
    @user = users(:minee)
    log_in_as(@user)
  end

  test "profile display" do
    get edit_user_path(@user)
    assert_template 'users/edit'
    assert_select 'h2', text: @user.name
    assert_select 'div.user-img'
    assert_select 'div.user-email'
    assert_select "a[href=?]", edit_user_path(@user), count: 1
    assert_select 'div.pagenation'

  end
end
