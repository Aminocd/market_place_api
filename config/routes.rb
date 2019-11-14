require 'api_constraints'

MarketPlaceApi::Application.routes.draw do
#  mount SabisuRails::Engine => "/sabisu_rails"
  get 'login_test', to: "login_test#show"
  get 'logged_in_test', to: "login_test#index"
  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               sign_out: 'logout',
               registration: 'signup'
             },controllers: {
               sessions: 'users/sessions',
               registrations: 'users/registrations',
               omniauth_callbacks: 'users/omniauth_callbacks'
      }

  devise_scope :user do
    post '/auth2/facebook/callback', to: 'users/omniauth_callbacks#facebook_token'
  end

  # Api definition
  namespace :api, defaults: { format: :json },
                              constraints: { subdomain: 'api' }, path: '/'  do
    scope module: :v1,
              constraints: ApiConstraints.new(version: 1, default: true) do
      # We are going to list our resources here
  		resources :users, :only => [:show, :update, :destroy] do
  			resources :products, :only => [:create, :update, :destroy]
  			resources :orders, :only => [:index, :show, :create]
  		end
		  resources :products, :only => [:show, :index]
    end
  end
end
