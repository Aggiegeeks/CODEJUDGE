require "test_helper"

class ProblemGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @problem_group = problem_groups(:one)
  end

  test "should get index" do
    get problem_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_problem_group_url
    assert_response :success
  end

  test "should create problem_group" do
    assert_difference("ProblemGroup.count") do
      post problem_groups_url, params: { problem_group: { group_id: @problem_group.group_id, problem_id: @problem_group.problem_id } }
    end

    assert_redirected_to problem_group_url(ProblemGroup.last)
  end

  test "should show problem_group" do
    get problem_group_url(@problem_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_problem_group_url(@problem_group)
    assert_response :success
  end

  test "should update problem_group" do
    patch problem_group_url(@problem_group), params: { problem_group: { group_id: @problem_group.group_id, problem_id: @problem_group.problem_id } }
    assert_redirected_to problem_group_url(@problem_group)
  end

  test "should destroy problem_group" do
    assert_difference("ProblemGroup.count", -1) do
      delete problem_group_url(@problem_group)
    end

    assert_redirected_to problem_groups_url
  end
end
