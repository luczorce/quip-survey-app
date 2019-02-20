Rails.application.routes.draw do
  resources :surveys do
    resources :questions, except: [:show, :update, :destroy]

    get '/results', to: 'surveys#get_all_results'
  end

  delete '/questions/:question_type/:id', to: 'questions#destroy'

  resources :questions, only: [:update] do
    # TODO add :index as we come to it
    resources :answers, only: :create
  end

  # TODO add destroy? do we want to have that capability?
  resources :answers, only: [:show, :update]
end
