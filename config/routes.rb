Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'dashboard#index'

  get     '/sign_up'  => 'clearance/users#new',         as: :sign_up
  get     '/sign_in'  => 'clearance/sessions#new',      as: :sign_in
  delete  '/sign_out' => 'clearance/sessions#destroy',  as: :sign_out

  resource  :session,   controller: 'clearance/sessions',  only: :create
  resources :passwords, controller: 'clearance/passwords', only: [:create, :new]
  resources :users,     controller: 'users',               only: :create do
    resource :password, controller: 'clearance/passwords', only: [:create, :edit, :update]
  end

  resources :lists, only: [:new, :create] do
    resources :tasks, controller: 'lists/tasks', only: [:new, :create, :update] do
      member do
        post :assign
      end
    end

    member do
      post :archive
    end
  end

  post '/search' => 'dashboard#index'
end
