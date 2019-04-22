class Course < ApplicationRecord
    has_many :topics, dependent: :destroy
end
