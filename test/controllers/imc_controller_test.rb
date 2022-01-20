require "test_helper"

class ImcControllerTest < ActionDispatch::IntegrationTest
  test "should get calculate" do
    get imc_calculate_url
    assert_response :success
  end
end
