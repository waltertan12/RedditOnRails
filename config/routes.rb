Rails.application.routes.draw do
  get 'static_pages/index'

  resource :user
  resource :session, only: [:new, :create, :destroy]
  resources :subs
  resources :posts, except: [:index] do
    resources :comments, only: [:new]
  end

  resources :comments, only: [:create, :show]

end
