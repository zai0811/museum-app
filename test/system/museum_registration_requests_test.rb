require "application_system_test_case"

class MuseumRegistrationRequestsTest < ApplicationSystemTestCase
  setup do
    @museum_registration_request = museum_registration_requests(:one)
  end

  test "visiting the index" do
    visit museum_registration_requests_url
    assert_selector "h1", text: "Museum registration requests"
  end

  test "should create museum registration request" do
    visit museum_registration_requests_url
    click_on "New museum registration request"

    fill_in "Manager email", with: @museum_registration_request.manager_email
    fill_in "Manager name", with: @museum_registration_request.manager_name
    fill_in "Museum address", with: @museum_registration_request.museum_address
    fill_in "Museum code", with: @museum_registration_request.museum_code
    fill_in "Museum name", with: @museum_registration_request.museum_name
    click_on "Create Museum registration request"

    assert_text "Museum registration request was successfully created"
    click_on "Back"
  end

  test "should update Museum registration request" do
    visit museum_registration_request_url(@museum_registration_request)
    click_on "Edit this museum registration request", match: :first

    fill_in "Manager email", with: @museum_registration_request.manager_email
    fill_in "Manager name", with: @museum_registration_request.manager_name
    fill_in "Museum address", with: @museum_registration_request.museum_address
    fill_in "Museum code", with: @museum_registration_request.museum_code
    fill_in "Museum name", with: @museum_registration_request.museum_name
    click_on "Update Museum registration request"

    assert_text "Museum registration request was successfully updated"
    click_on "Back"
  end

  test "should destroy Museum registration request" do
    visit museum_registration_request_url(@museum_registration_request)
    click_on "Destroy this museum registration request", match: :first

    assert_text "Museum registration request was successfully destroyed"
  end
end
