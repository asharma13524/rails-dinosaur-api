Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :dinosaurs, only: [:index, :create, :update, :destroy]
  resources :cages, only: [:index, :create, :update, :destroy]
  resources :dinosaurs, only: :show, param: :species
  resources :cages, only: :show, param: :cage_status

end
