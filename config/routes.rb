Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: 'users/sessions' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'application#home'

  resources :customers
  resources :projects

  resources :tasks do
    post 'completion', on: :member
  end

  Rails.application.routes.draw do
    # having created corresponding controller and action
    get '*path', to: 'errors#error_404', via: :all
  end
end
