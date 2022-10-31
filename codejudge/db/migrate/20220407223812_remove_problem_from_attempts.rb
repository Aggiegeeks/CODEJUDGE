class RemoveProblemFromAttempts < ActiveRecord::Migration[7.0]
  def change
    remove_column :attempts, :problem_id, :bigint
  end
end
