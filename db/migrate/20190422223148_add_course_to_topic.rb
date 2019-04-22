class AddCourseToTopic < ActiveRecord::Migration[5.2]
  def change
    add_reference :topics, :course, foreign_key: true
  end
end
