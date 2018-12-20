Rails.application.routes.draw do
  resources :surveys do
    resources :questions, except: [:show, :update, :destroy]
  end

  resources :questions, only: [:update, :destroy]
end
