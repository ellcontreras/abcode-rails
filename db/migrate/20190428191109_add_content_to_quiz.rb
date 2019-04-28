class AddContentToQuiz < ActiveRecord::Migration[5.2]
  def change
    add_column :quizzes, :content, :string
  end
end
