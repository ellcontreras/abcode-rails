class Quiz < ApplicationRecord
    belongs_to :lesson, dependent: :destroy
end
