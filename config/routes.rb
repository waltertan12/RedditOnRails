Rails.application.routes.draw do
  get 'static_pages/index'

  resource :user
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
    member do
      post :upvote
      post :downvote
    end
  end

  resources :comments, only: [:create, :show]
end
