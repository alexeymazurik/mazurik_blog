Rails.application.routes.draw do
  root to: 'posts#index'

  resources :posts do
    member do
      post   :like
      delete :like,     action: :unlike,     as: :unlike
      post   :dislike
      delete :dislike,  action: :undislike,  as: :undislike
    end
  end

  resources :sections, only: %w(index create update destroy)
  resources :tags, only: %w(index)

  devise_for :users
end
