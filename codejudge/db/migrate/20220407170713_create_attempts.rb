class CreateAttempts < ActiveRecord::Migration[7.0]
  def change
    create_table :attempts do |t|
      t.bigint :user_id
      t.bigint :problem_id
      t.text :code
      t.bigint :language_id

      t.timestamps
    end
  end
end
