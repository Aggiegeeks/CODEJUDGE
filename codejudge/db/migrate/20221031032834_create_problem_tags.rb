class CreateProblemTags < ActiveRecord::Migration[7.0]
  def change
    create_table :problem_tags do |t|
      t.bigint :problem_id
      t.bigint :tag_id

      t.timestamps
    end
  end
end
