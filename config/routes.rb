# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  scope '/api', format: :json do
    get 'users/:page', to: 'users#index'
    get '/user/:id', to: 'users#show'
    delete 'user/:id', to: 'users#delete'
    put 'user/:id', to: 'users#update'
    post 'user', to: 'users#create'
    get 'user/typeahead/:term', to: 'users#typeahead'
  end
end
