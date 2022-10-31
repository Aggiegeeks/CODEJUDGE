require "application_system_test_case"

class ProblemTagsTest < ApplicationSystemTestCase
  setup do
    @problem_tag = problem_tags(:one)
  end

  test "visiting the index" do
    visit problem_tags_url
    assert_selector "h1", text: "Problem tags"
  end

  test "should create problem tag" do
    visit problem_tags_url
    click_on "New problem tag"

    fill_in "Problem", with: @problem_tag.problem_id
    fill_in "Tag", with: @problem_tag.tag_id
    click_on "Create Problem tag"

    assert_text "Problem tag was successfully created"
    click_on "Back"
  end

  test "should update Problem tag" do
    visit problem_tag_url(@problem_tag)
    click_on "Edit this problem tag", match: :first

    fill_in "Problem", with: @problem_tag.problem_id
    fill_in "Tag", with: @problem_tag.tag_id
    click_on "Update Problem tag"

    assert_text "Problem tag was successfully updated"
    click_on "Back"
  end

  test "should destroy Problem tag" do
    visit problem_tag_url(@problem_tag)
    click_on "Destroy this problem tag", match: :first

    assert_text "Problem tag was successfully destroyed"
  end
end
