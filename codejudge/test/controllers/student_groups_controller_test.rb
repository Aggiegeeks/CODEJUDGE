require "test_helper"

class StudentGroupsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @student_group = student_groups(:one)
  end

  test "should get index" do
    get student_groups_url
    assert_response :success
  end

  test "should get new" do
    get new_student_group_url
    assert_response :success
  end

  test "should create student_group" do
    assert_difference("StudentGroup.count") do
      post student_groups_url, params: { student_group: { group_id: @student_group.group_id, user_id: @student_group.user_id } }
    end

    assert_redirected_to student_group_url(StudentGroup.last)
  end

  test "should show student_group" do
    get student_group_url(@student_group)
    assert_response :success
  end

  test "should get edit" do
    get edit_student_group_url(@student_group)
    assert_response :success
  end

  test "should update student_group" do
    patch student_group_url(@student_group), params: { student_group: { group_id: @student_group.group_id, user_id: @student_group.user_id } }
    assert_redirected_to student_group_url(@student_group)
  end

  test "should destroy student_group" do
    assert_difference("StudentGroup.count", -1) do
      delete student_group_url(@student_group)
    end

    assert_redirected_to student_groups_url
  end
end
