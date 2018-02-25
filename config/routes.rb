Rails.application.routes.draw do
	root "posts#index"

  resources :posts, only: [:index, :show]
  resources :attachments, only: [:show]
  resources :tags, only: [:show]

	get "admin", to: redirect("admin/posts")
	
	get "signin", to: "sessions#new"
  post "signin", to: "sessions#create"
  delete "logout", to: "sessions#destroy"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :admin do
    resources :posts
    resources :attachments
  end
end
