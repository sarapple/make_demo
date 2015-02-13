require 'test_helper'

class SplashesControllerTest < ActionController::TestCase
  test "should get splash" do
    get :splash
    assert_response :success
  end

end
