class CourseProgress < ApplicationRecord
  belongs_to :course_user
  belongs_to :topic
  belongs_to :lesson
end
