class CreateCourseProgresses < ActiveRecord::Migration[5.2]
  def change
    create_table :course_progresses do |t|
      t.references :course_user, foreign_key: true
      t.references :topic, foreign_key: true
      t.references :lesson, foreign_key: true
      t.boolean :course_ended

      t.timestamps
    end
  end
end
