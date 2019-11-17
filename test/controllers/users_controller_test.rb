require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
 
  test "should get user index" do
    get users_path
    assert_response :success
    assert_select "title", "users-index | Anima"
  end

end
