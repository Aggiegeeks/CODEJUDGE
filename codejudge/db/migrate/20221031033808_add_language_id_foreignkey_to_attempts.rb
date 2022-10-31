class AddLanguageIdForeignkeyToAttempts < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :attempts, :languages, column: :language_id
  end
end
