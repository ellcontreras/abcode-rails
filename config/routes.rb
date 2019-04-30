Rails.application.routes.draw do
  resources :courses do
    resources :topics do
      resources :lessons
    end
  end

  get "/dashboard" => "dashboard#index"

  get "/course/play/:course_id" => "course_in_progress#index"

  root "courses#courses_index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
