Rails.application.routes.draw do
  resources :predictions
  root 'predictions#new'
end
