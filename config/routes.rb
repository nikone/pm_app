Rails.application.routes.draw do
  devise_for :users
  root 'application#index'

  resources :projects, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json } do
    resources :boards, only: [:index]
  end

  resources :tasks, only: [:show, :create], defaults: { format: :json }
end
