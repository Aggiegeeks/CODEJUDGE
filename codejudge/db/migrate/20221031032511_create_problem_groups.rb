class CreateProblemGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :problem_groups do |t|
      t.bigint :group_id
      t.bigint :problem_id

      t.timestamps
    end
  end
end
