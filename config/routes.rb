Rails.application.routes.draw do
  devise_for :users
  root "dashboard#index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  resources :schools
  resources :students
  resources :professionals
  resources :courses do
    resources :enrollments, only: [:create, :destroy]
  end

  resources :attendances

  # Dashboard routes
  get   "dashboard",               to: "dashboard#index"
  patch "dashboard/select_school", to: "dashboard#select_school"
  get   "dashboard/list_students", to: "dashboard#list_students"
  get   "dashboard/list_professionals", to: "dashboard#list_professionals"
end
