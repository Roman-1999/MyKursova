Rails.application.routes.draw do
    get 'pages/home'

	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
    resources :organizations do
    	resources :repositories
    end
	root to: 'pages#home'

	get '/api/test', to: 'repositories#test', as: 'api_test'
end