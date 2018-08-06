Rails.application.routes.draw do
  get 'home/index'
  post 'dashboards/copy/:id', to: 'dashboards#copy', as: :copy_dashboard
  devise_for :users
  resources :dashboards, only: [:new, :create, :index, :show, :edit, :destroy, :update] do
    resources :lists, only: [:new, :create]
  end
  resources :lists, only: [:index]
  root to: "home#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
