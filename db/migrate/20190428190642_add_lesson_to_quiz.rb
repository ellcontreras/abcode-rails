class AddLessonToQuiz < ActiveRecord::Migration[5.2]
  def change
    add_reference :quizzes, :lesson, foreign_key: true
  end
end
