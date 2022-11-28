class AddTestScoreToAttempts < ActiveRecord::Migration[7.0]
  def change
    add_column :attempts, :testScore, :bigint
  end
end
