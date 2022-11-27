class AddClasscodeToGroups < ActiveRecord::Migration[7.0]
  def change
    add_column :groups, :classcode, :string
  end
end
