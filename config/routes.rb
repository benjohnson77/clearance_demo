Rails.application.routes.draw do
  resources :clearance_batches, only: [:index, :create, :show]
  resources :items, only: [:index, :create, :update, :export]
  resources :styles, only: [:index, :create, :update, :show]
  root to: "clearance_batches#index"
end
