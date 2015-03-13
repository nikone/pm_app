Rails.application.routes.draw do
  devise_for :users
  root 'application#index'

  resources :projects, only: [:index, :show, :create, :update, :destroy], defaults: { format: :json } do
    resources :tasks, only: [:index, :show, :create, :update, :destroy], shallow: true, defaults: { format: :json }
    resources :boards, only: [:create], shallow: true, defaults: { format: :json }
  end

  get '/boards/:id/completed_tasks', to: 'boards#completed_tasks', as: :board_completed_tasks, defaults: { format: :json }
end
