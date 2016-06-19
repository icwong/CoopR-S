require 'test_helper'

class UserControllerTest < ActionController::TestCase
  test "Registration Init" do
    get '/users/sign_up'
    assert_response :success
  end

end
