require "test_helper"

class MuseumRegistrationRequestsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @museum_registration_request = museum_registration_requests(:one)
  end

  test "should get index" do
    get museum_registration_requests_url
    assert_response :success
  end

  test "should get new" do
    get new_museum_registration_request_url
    assert_response :success
  end

  test "should create museum_registration_request" do
    assert_difference("MuseumRegistrationRequest.count") do
      post museum_registration_requests_url, params: { museum_registration_request: { manager_email: @museum_registration_request.manager_email, manager_name: @museum_registration_request.manager_name, museum_address: @museum_registration_request.museum_address, museum_code: @museum_registration_request.museum_code, museum_name: @museum_registration_request.museum_name } }
    end

    assert_redirected_to museum_registration_request_url(MuseumRegistrationRequest.last)
  end

  test "should show museum_registration_request" do
    get museum_registration_request_url(@museum_registration_request)
    assert_response :success
  end

  test "should get edit" do
    get edit_museum_registration_request_url(@museum_registration_request)
    assert_response :success
  end

  test "should update museum_registration_request" do
    patch museum_registration_request_url(@museum_registration_request), params: { museum_registration_request: { manager_email: @museum_registration_request.manager_email, manager_name: @museum_registration_request.manager_name, museum_address: @museum_registration_request.museum_address, museum_code: @museum_registration_request.museum_code, museum_name: @museum_registration_request.museum_name } }
    assert_redirected_to museum_registration_request_url(@museum_registration_request)
  end

  test "should destroy museum_registration_request" do
    assert_difference("MuseumRegistrationRequest.count", -1) do
      delete museum_registration_request_url(@museum_registration_request)
    end

    assert_redirected_to museum_registration_requests_url
  end
end
