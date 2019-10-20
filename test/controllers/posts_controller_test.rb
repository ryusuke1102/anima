require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get posts_path
    assert_response :success
    assert_select "title", "posts | Anima"
  end
  
end
