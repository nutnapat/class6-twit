Rails.application.routes.draw do
  resources :likes
  resources :follows
  resources :posts
  resources :users
  get "main" , to:"users#login"
  post "main" , to:"users#checklog"
  get "feed" , to:"users#feed"
  post "feed" , to:"users#feed"
  get "new_post" , to:"posts#new"
  get "profile/:name" , to:"users#profile"
  post "profile/:name" , to:"users#profile"
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  post 'feed/:post_id/like', to: 'posts#like', as: "like_post"
  post 'feed/:post_id/unlike', to: 'posts#unlike',as: "unlike_post"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
