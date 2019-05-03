class CourseProgress < ApplicationRecord
  has_many :course_user
  belongs_to :topic
  belongs_to :lesson
end
