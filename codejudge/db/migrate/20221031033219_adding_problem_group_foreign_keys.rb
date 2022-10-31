class AddingProblemGroupForeignKeys < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :problem_groups, :groups, column: :group_id
    add_foreign_key :problem_groups, :problems, column: :problem_id
  end
end
