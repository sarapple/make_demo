require 'test_helper'

class TestersControllerTest < ActionController::TestCase
  test "should get tester" do
    get :tester
    assert_response :success
  end

end
