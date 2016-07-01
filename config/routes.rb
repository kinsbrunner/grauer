Grauer::Application.routes.draw do
  devise_for :users

  root 'schools#index'
  resources :schools, only: [:index] do
    resources :families, only: [:index, :new, :create, :show, :edit, :update] do
      resources :children, only: [:new, :create, :edit, :update, :destroy]
      resources :comments, only: [:new, :create]
      resources :movements, only: [:new, :create, :destroy]
    end
  end
  resources :foods, only: [:index, :new, :create, :destroy, :edit, :update]
  resources :menus, only: [:index, :create, :update, :destroy] do
    get :get_menus, on: :collection
  end
  resources :bills, only: [:index, :new, :create, :destroy]
end