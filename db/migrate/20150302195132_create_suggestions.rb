class CreateSuggestions < ActiveRecord::Migration
  def change
    create_table :suggestions do |t|
      t.string :email
      t.text :suggestion

      t.timestamps
    end
  end
end
