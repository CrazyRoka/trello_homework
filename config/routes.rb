Rails.application.routes.draw do
  get 'home/index'
  post 'dashboards/copy/:id', to: 'dashboards#copy', as: :copy_dashboard
  devise_for :users
  resources :dashboards do
    resources :lists, only: [:new, :create, :destroy]
  end
  resources :lists, only: [:index, :update] do
    resources :cards, only: [:new, :create]
  end
  resources :cards, only: [:update]
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
