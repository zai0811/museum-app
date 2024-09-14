require "test_helper"

class ObjectTypesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @object_type = object_types(:one)
  end

  test "should get index" do
    get object_types_url
    assert_response :success
  end

  test "should get new" do
    get new_object_type_url
    assert_response :success
  end

  test "should create object_type" do
    assert_difference("ObjectType.count") do
      post object_types_url, params: { object_type: { name: @object_type.name } }
    end

    assert_redirected_to object_type_url(ObjectType.last)
  end

  test "should show object_type" do
    get object_type_url(@object_type)
    assert_response :success
  end

  test "should get edit" do
    get edit_object_type_url(@object_type)
    assert_response :success
  end

  test "should update object_type" do
    patch object_type_url(@object_type), params: { object_type: { name: @object_type.name } }
    assert_redirected_to object_type_url(@object_type)
  end

  test "should destroy object_type" do
    assert_difference("ObjectType.count", -1) do
      delete object_type_url(@object_type)
    end

    assert_redirected_to object_types_url
  end
end
