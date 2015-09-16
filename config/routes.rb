Rails.application.routes.draw do
  get 'collaborator/index'

  devise_for :users

  resources :wikis do
    resources :collaborators
    post :create_collaborators
    delete :destroy_collaborators
  end

  resources :charges, only: [:new, :create]
  put 'downgrade' => 'charges#downgrade'
  get 'welcome/index'

  root to: 'welcome#index'
end
