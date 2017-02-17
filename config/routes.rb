Rails.application.routes.draw do

  root to: "users#welcome"

  resources :users, only: [:new, :create, :show]

  resources :attractions, only: [:index, :show, :new, :create, :edit, :update, :destroy]

  post '/ride' => "attractions#ride"

  get '/signin' => "sessions#new"
  post '/signin' => "sessions#create"
  delete '/signout' => "sessions#destroy"
end
