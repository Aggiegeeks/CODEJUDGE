class CreateGroups < ActiveRecord::Migration[7.0]
  def change
    create_table :groups do |t|
      t.integer :author_id
      t.string :group_title
      t.text :description

      t.timestamps
    end
  end
end
