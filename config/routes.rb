Grauer::Application.routes.draw do
  devise_for :users

  root 'schools#index'
  resources :schools, only: [:index] do
    resources :families, only: [:index, :new, :create, :show, :edit, :update] do
      resources :students, only: [:new, :create]
    end
  end
end