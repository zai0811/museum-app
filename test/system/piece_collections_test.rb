require "application_system_test_case"

class PieceCollectionsTest < ApplicationSystemTestCase
  setup do
    @piece_collection = piece_collections(:one)
  end

  test "visiting the index" do
    visit piece_collections_url
    assert_selector "h1", text: "Piece collections"
  end

  test "should create piece collection" do
    visit piece_collections_url
    click_on "New piece collection"

    fill_in "Museum", with: @piece_collection.museum_id
    fill_in "Name", with: @piece_collection.name
    fill_in "Status", with: @piece_collection.status
    click_on "Create Piece collection"

    assert_text "Piece collection was successfully created"
    click_on "Back"
  end

  test "should update Piece collection" do
    visit piece_collection_url(@piece_collection)
    click_on "Edit this piece collection", match: :first

    fill_in "Museum", with: @piece_collection.museum_id
    fill_in "Name", with: @piece_collection.name
    fill_in "Status", with: @piece_collection.status
    click_on "Update Piece collection"

    assert_text "Piece collection was successfully updated"
    click_on "Back"
  end

  test "should destroy Piece collection" do
    visit piece_collection_url(@piece_collection)
    click_on "Destroy this piece collection", match: :first

    assert_text "Piece collection was successfully destroyed"
  end
end
