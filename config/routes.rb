Tarla::Application.routes.draw do |map|
  resources :locations, :only => [:index]
  resources :sightings, :only => [:index, :new, :create]
  resources :votes, :only => [:create]
  
  root :to => 'sightings#index'
end
