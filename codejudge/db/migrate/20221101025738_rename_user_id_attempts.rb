class RenameUserIdAttempts < ActiveRecord::Migration[7.0]
  def change
    rename_column :attempts, :users_id, :user_id
  end
end
