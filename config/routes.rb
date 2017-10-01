Rails.application.routes.draw do

  resources :diagrams
  resources :ontologies
  get 'ontologies/:id/query', to: 'ontologies#sparql_query', as: 'sparql'

  resources :lanes
  resources :business_processes
  get '/bpmn/modeler' => 'bpmn#modeler'
  get '/bpmn/viewer' => 'bpmn#viewer'
  get '/bpmn/parser' => 'bpmn#parser'
  get '/bpmn/create' => 'bpmn#create'
#  post 'sparql' => 'ontologies#sparql_query'

  resources :sequence_flows
  resources :tasks
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: "home#index"
  
  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
