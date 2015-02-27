class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :answer
      t.belongs_to :question, index: true
      
      t.timestamps
    end
  end
end
