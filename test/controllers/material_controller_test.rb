require "test_helper"

class MaterialControllerTest < ActionDispatch::IntegrationTest
  test "should get name:string" do
    get material_name:string_url
    assert_response :success
  end
end
