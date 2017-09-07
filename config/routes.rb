Rails.application.routes.draw do
  get '/bpmn/modeler' => 'bpmn#modeler'
  get '/bpmn/viewer' => 'bpmn#viewer'
  get '/bpmn/parser' => 'bpmn#parser'
  resources :sequence_flows
  resources :tasks
  resources :diagrams
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "home#index"
  
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
