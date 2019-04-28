json.extract! lesson, :id, :name, :content, :is_quiz, :created_at, :updated_at
json.url lesson_url(lesson, format: :json)
