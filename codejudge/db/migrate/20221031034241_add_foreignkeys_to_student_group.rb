class AddForeignkeysToStudentGroup < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :student_groups, :groups, column: :group_id
    add_foreign_key :student_groups, :users, column: :user_id
  end
end
