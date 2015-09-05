Rails.application.routes.draw do
  devise_for :users

  resources :wikis
  resources :charges, only: [:new, :create]
  put 'downgrade' => 'charges#downgrade'
  get 'welcome/index'

  root to: 'welcome#index'
end
