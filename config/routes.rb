Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations', omniauth_callbacks: 'callbacks'}

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  root to: 'appointments#index'

  # Route will allow deletion of all expired appointments /w button click
  delete 'appointments/delete_all', to: 'appointments#destroy_all_expired'
  
  # Nested Routes for appointments inside of patients
  # /patients/:id/appointments/new
  # /patients/:id/appointments/:id/edit
  resources :patients do
    resources :appointments
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
