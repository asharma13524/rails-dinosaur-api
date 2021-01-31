require "test_helper"

class CagesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cages_index_url
    assert_response :success
  end
end
