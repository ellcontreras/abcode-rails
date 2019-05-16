class Lesson < ApplicationRecord
    belongs_to :topic, dependent: :destroy
    has_one :quiz, dependent: :destroy
end
