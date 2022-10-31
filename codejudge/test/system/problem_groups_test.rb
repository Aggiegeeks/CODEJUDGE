require "application_system_test_case"

class ProblemGroupsTest < ApplicationSystemTestCase
  setup do
    @problem_group = problem_groups(:one)
  end

  test "visiting the index" do
    visit problem_groups_url
    assert_selector "h1", text: "Problem groups"
  end

  test "should create problem group" do
    visit problem_groups_url
    click_on "New problem group"

    fill_in "Group", with: @problem_group.group_id
    fill_in "Problem", with: @problem_group.problem_id
    click_on "Create Problem group"

    assert_text "Problem group was successfully created"
    click_on "Back"
  end

  test "should update Problem group" do
    visit problem_group_url(@problem_group)
    click_on "Edit this problem group", match: :first

    fill_in "Group", with: @problem_group.group_id
    fill_in "Problem", with: @problem_group.problem_id
    click_on "Update Problem group"

    assert_text "Problem group was successfully updated"
    click_on "Back"
  end

  test "should destroy Problem group" do
    visit problem_group_url(@problem_group)
    click_on "Destroy this problem group", match: :first

    assert_text "Problem group was successfully destroyed"
  end
end
