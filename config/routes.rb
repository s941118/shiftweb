Rails.application.routes.draw do
	root "posts#index"

  resources :posts, only: [:index, :show]
  resources :attachments, only: [:show]
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	namespace :admin do
    resources :tags
    resources :posts
    resources :attachments
  end
	get 'admin', to: redirect('/admin/posts')
	namespace :admin do
		resources :users
		get 'signin', to: 'sessions#new'
		post 'signin', to: 'sessions#create'
		delete 'logout', to: 'sessions#destroy'
	end
end