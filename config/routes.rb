Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dinosaurs, only: [:index, :create, :update, :destroy]
  resources :cages, only: [:index, :create, :destroy]
end
