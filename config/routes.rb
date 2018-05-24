Rails.application.routes.draw do
    get 'pages/home'

	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
	resources :issues, only: :index
    resources :repositories
	root to: 'pages#home'

	get '/api/test', to: 'repositories#test', as: 'api_test'
end