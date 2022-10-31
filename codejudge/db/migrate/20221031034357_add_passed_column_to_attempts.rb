class AddPassedColumnToAttempts < ActiveRecord::Migration[7.0]
  def change
    add_column :attempts, :passed, :boolean
  end
end
