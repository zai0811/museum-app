require "application_system_test_case"

class ObjectTypesTest < ApplicationSystemTestCase
  setup do
    @object_type = object_types(:one)
  end

  test "visiting the index" do
    visit object_types_url
    assert_selector "h1", text: "Object types"
  end

  test "should create object type" do
    visit object_types_url
    click_on "New object type"

    fill_in "Name", with: @object_type.name
    click_on "Create Object type"

    assert_text "Object type was successfully created"
    click_on "Back"
  end

  test "should update Object type" do
    visit object_type_url(@object_type)
    click_on "Edit this object type", match: :first

    fill_in "Name", with: @object_type.name
    click_on "Update Object type"

    assert_text "Object type was successfully updated"
    click_on "Back"
  end

  test "should destroy Object type" do
    visit object_type_url(@object_type)
    click_on "Destroy this object type", match: :first

    assert_text "Object type was successfully destroyed"
  end
end
