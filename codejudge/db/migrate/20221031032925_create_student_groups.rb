class CreateStudentGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :student_groups do |t|
      t.bigint :group_id
      t.bigint :user_id

      t.timestamps
    end
  end
end
