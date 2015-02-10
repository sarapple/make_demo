require 'test_helper'

class DemonstrationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get doc" do
    get :doc
    assert_response :success
  end

end
