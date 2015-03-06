Rails.application.routes.draw do
  devise_for :users
  root 'application#index'

  resources :projects, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json } do
    #resources :boards, only: [:index]
    resources :tasks, only: [:index, :show, :create, :update, :destroy], shallow: true, defaults: { format: :json }
  end
end
