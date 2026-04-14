Rails.application.routes.draw do
  root "students#index"
  resources :students, only: [:index, :show] do
    member do
      get :ai_message
    end
  end
end