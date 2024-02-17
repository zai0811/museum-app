require "test_helper"

class MuseumsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @museum = museums(:one)
  end

  test "should get index" do
    get museums_url
    assert_response :success
  end

  test "should get new" do
    get new_museum_url
    assert_response :success
  end

  test "should create museum" do
    assert_difference("Museum.count") do
      post museums_url, params: { museum: { about: @museum.about, address: @museum.address, email: @museum.email, name: @museum.name, page: @museum.page, phone: @museum.phone, user_id: @museum.user_id } }
    end

    assert_redirected_to museum_url(Museum.last)
  end

  test "should show museum" do
    get museum_url(@museum)
    assert_response :success
  end

  test "should get edit" do
    get edit_museum_url(@museum)
    assert_response :success
  end

  test "should update museum" do
    patch museum_url(@museum), params: { museum: { about: @museum.about, address: @museum.address, email: @museum.email, name: @museum.name, page: @museum.page, phone: @museum.phone, user_id: @museum.user_id } }
    assert_redirected_to museum_url(@museum)
  end

  test "should destroy museum" do
    assert_difference("Museum.count", -1) do
      delete museum_url(@museum)
    end

    assert_redirected_to museums_url
  end
end
