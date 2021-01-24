Rails.application.routes.draw do
  devise_for :users
  root to: 'articles#index'
  resources :articles do
    resources :tags do
      collection do
        get 'search'
      end
    end
    resources :comments, only: :create
    collection do
      get 'search'
    end
    resources :favorites, only: [:create, :destroy]
  end
  resources :users, only: :show do
    get :favorites, on: :collection
    get :followings, :followers, on: :member
  end
  resources :relationships, only: [:create, :destroy]

  post 'like/:article_id' ,to: 'likes#like', as: 'like'
  delete 'like/:article_id', to: 'likes#unlike', as: 'unlike'

end