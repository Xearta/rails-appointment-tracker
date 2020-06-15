Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: 'callbacks'}

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  root to: 'appointments#index'
  
  resources :patients do
    resources :appointments
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
