Rails.application.routes.draw do
  root 'pages#home'

  controller :pages do
  	get "works"
  	get "member"
  	get "about"
  	get "contact"
  end

  resources :posts, only: [:index, :show]
  resources :attachments, only: [:show]
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	namespace :admin do
    resources :tags
    resources :posts do
      member do
        post "publish"
        post "draft"
      end
    end
    resources :contents
  end
	get 'admin', to: redirect('/admin/posts')
	namespace :admin do
		resources :users
	end
  get 'signin', to: 'sessions#new'
  post 'signin', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end