require 'test_helper'

class SiteLayoutTestTest < ActionDispatch::IntegrationTest


  test "layout link" do
    get root_path
    assert_template 'home/top'
    assert_select "a[href=?]", root_path, count: 1
    assert_select "a[href=?]", posts_path, count: 1
    assert_select "a[href=?]", login_path, count: 1
    assert_select "a[href=?]", signup_path, count: 1
  end
 
end
