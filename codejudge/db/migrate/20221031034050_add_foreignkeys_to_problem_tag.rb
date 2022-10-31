class AddForeignkeysToProblemTag < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :problem_tags, :problems, column: :problem_id
    add_foreign_key :problem_tags, :tags, column: :tag_id
  end
end
