class CourseUser < ApplicationRecord
  belongs_to :user
  belongs_to :course

  has_many :course_progress
end
