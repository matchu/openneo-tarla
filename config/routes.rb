Tarla::Application.routes.draw do |map|
  resources :all_clears, :only => [:create]
  resources :locations, :only => [:index]
  resources :sightings, :only => [:index, :new, :create]
  resources :votes, :only => [:create]
  
  root :to => 'high_voltage/pages#show', :id => 'home'
end
