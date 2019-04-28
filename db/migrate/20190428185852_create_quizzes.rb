class CreateQuizzes < ActiveRecord::Migration[5.2]
  def change
    create_table :quizzes do |t|
      t.string :name
      t.string :answer1
      t.string :answer2
      t.string :answer3
      t.boolean :which_correct

      t.timestamps
    end
  end
end
