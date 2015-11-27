Rails.application.routes.draw do
  root 'repositories#index'
  resources :repositories do
    member do
      patch :like
      patch :dislike
    end
  end
end
