Rails.application.routes.draw do
  root to: redirect('posts')

  resources :posts do
    member do
      post 'like'
      post 'unlike'
    end
  end

  resources :sections, only: %w(index create update destroy)
  resources :tags, only: %w(index)

  devise_for :users
end
