Rails.application.routes.draw do
  resources :follows
  resources :posts
  resources :users
  get "main" , to:"users#login"
  post "main" , to:"users#checklog"
  get "feed" , to:"users#feed"
  post "feed" , to:"users#feed"
  get "new_post" , to:"posts#new"
  get "profile/:name" , to:"users#profile"
  post '/users/:id/follow', to: "users#follow", as: "follow_user"
  post '/users/:id/unfollow', to: "users#unfollow", as: "unfollow_user"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
