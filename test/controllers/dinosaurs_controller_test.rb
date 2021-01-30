require "test_helper"

class DinosaursControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get dinosaurs_index_url
    assert_response :success
  end
end
