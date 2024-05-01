require "test_helper"

class PieceCollectionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @piece_collection = piece_collections(:one)
  end

  test "should get index" do
    get piece_collections_url
    assert_response :success
  end

  test "should get new" do
    get new_piece_collection_url
    assert_response :success
  end

  test "should create piece_collection" do
    assert_difference("PieceCollection.count") do
      post piece_collections_url, params: { piece_collection: { museum_id: @piece_collection.museum_id, name: @piece_collection.name, status: @piece_collection.status } }
    end

    assert_redirected_to piece_collection_url(PieceCollection.last)
  end

  test "should show piece_collection" do
    get piece_collection_url(@piece_collection)
    assert_response :success
  end

  test "should get edit" do
    get edit_piece_collection_url(@piece_collection)
    assert_response :success
  end

  test "should update piece_collection" do
    patch piece_collection_url(@piece_collection), params: { piece_collection: { museum_id: @piece_collection.museum_id, name: @piece_collection.name, status: @piece_collection.status } }
    assert_redirected_to piece_collection_url(@piece_collection)
  end

  test "should destroy piece_collection" do
    assert_difference("PieceCollection.count", -1) do
      delete piece_collection_url(@piece_collection)
    end

    assert_redirected_to piece_collections_url
  end
end
