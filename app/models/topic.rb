class Topic < ApplicationRecord
    belongs_to :course, dependent: :destroy
    has_many :lessons, dependent: :destroy
end
