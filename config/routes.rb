Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'home/index'

  resources :login, only:[:index, :create]
  resources :signup, only:[:index, :create]
  resources :logout, only:[:index]
  resources :account, only:[:index]
  resources :orders, only:[:show]
  resources :products, only:[:index, :show]
  resources :category, only:[:index, :show]
  resources :search, only:[:index]
  resources :about, only:[:index]

  resources :cart, only:[:create, :destroy, :index, :update]

  root to: "home#index"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # resources :products, only:[:index, :show]

  # /checkout/create something
  scope "/checkout" do
    post "create", to: "checkout#create", as: "checkout_create"
    get "success", to: "checkout#success", as: "checkout_success"
    get "cancel", to: "checkout#cancel", as: "checkout_cancel"
  end
end
