json.extract! course, :id, :name, :description, :category, :created_at, :updated_at
json.url course_url(course, format: :json)
