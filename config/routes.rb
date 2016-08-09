Grauer::Application.routes.draw do
  devise_for :users

  root 'schools#index'
  resources :schools, only: [:index, :new, :create] do
    resources :families, only: [:index, :new, :create, :show, :edit, :update] do
      resources :children, only: [:new, :create, :edit, :update, :destroy]
      resources :comments, only: [:new, :create]
      resources :movements, only: [:new, :create, :destroy]
      member do
        get 'enable'
        get 'disable'
      end
    end
    resources :notifications, only: [:index]
    resources :lists, only: [:show]
    resources :evolutions, only: [:index, :create]  
    resources :bills, only: [:index, :new, :create, :destroy, :edit, :update]
  end
  resources :foods, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :menus, only: [:index, :create, :update, :destroy] do
    get :get_menus, on: :collection
  end
end