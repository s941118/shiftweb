Rails.application.routes.draw do
  root 'pages#home'

  controller :pages do
  	get "works"
  	get "members"
  	get "about"
  	get "contact"
  end

  resources :works, only: [:show]
  resources :tags, only: [:show]
	
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	namespace :admin do
    resources :tags
    resources :works do
      member do
        post "publish"
        post "draft"
      end
    end
    resources :contents
  end
	get 'admin', to: redirect('/admin/works')
	namespace :admin do
		resources :users
    get 'login', to: 'sessions#new'
    post 'signin', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
	end

  match "/404", :to => "errors#not_found", :via => :all
  match "/500", :to => "errors#internal_server_error", :via => :all
end