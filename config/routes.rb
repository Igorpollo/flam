Treebook::Application.routes.draw do
  
  
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" }
  resources :clientes

  devise_scope :user do
  get "register", to: "devise/registrations#new", as: :register
end
  
  
  resources :user_followers do
    member do
      post :new
    end
  end
  # match "/user_followers/new", to: "user_followers#new", via: :post
 

  root to: 'photos#flow'

  get "/:id", to: "profiles#show", as: :profile

  scope ':profile_name' do
    resources :photos
   end 

   match "profile/edit" => "profiles#edit", via: [:get, :post]

   match "photos/comment" => "photos#comment", via: [:get, :post]

   match ":id/followers" => "user_followers#new", via: [:get, :post]

   match ":id/followers" => "user_followers#destroy", via: [:delete]

   match ":id/likes" => "profiles#like", via: [:get, :post], as: :profile_likes

   match ":id/likes" => "profiles#dislike", via: [:delete]

   match ":id/favorites" => "profiles#favorite", via: [:get, :post], as: :profile_favorites

   match ":id/favorites" => "profiles#unfavorite", via: [:delete]
  
  match "photos/upload" => "photos#new", via: [:get, :post], as: :upload_photo
  
  
end
