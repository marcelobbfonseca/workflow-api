Rails.application.routes.draw do
  get '/modeler' => 'bpmn#modeler'
  get '/viewer' => 'bpmn#viewer'
  resources :sequence_flows
  resources :tasks
  resources :diagrams
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "home#index"
  
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
