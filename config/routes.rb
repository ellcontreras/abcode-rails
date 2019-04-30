Rails.application.routes.draw do
  devise_for :users
  resources :courses do
    resources :topics do
      resources :lessons
    end
  end

  get "/dashboard" => "dashboard#index"

  get "/course/play/:course_id" => "course_in_progress#index"

  post "/upload_image" => "upload#upload_image", :as => :upload_image
  get "/download_file/:name" => "upload#access_file", :as => :upload_access_file, :name => /.*/

  root "courses#courses_index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
