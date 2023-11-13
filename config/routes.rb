Rails.application.routes.draw do
  devise_for :users
  resources :tags
  root 'home#index'
  get '/posts', to:'posts#index'
  get 'tags/list/:tag', to: 'posts#index', as: :list_tagged_posts
  resources :topics do
    resources :posts do
      post "read_unread", on: :member
      resources :ratings
      resources :comments do
        resources :user_comment_ratings
      end
    end
  end

end
