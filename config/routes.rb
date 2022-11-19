Rails.application.routes.draw do
  get '/member-data', to: 'members#show'
  resources :courses
  resources :course_registrations
  resources :terms
  resources :term_registrations
  devise_scope :user do
    put 'update', to: 'registrations#update'
    put 'passupdate', to: 'registrations#update_password'
    end
  devise_for :users, 
    path: '', 
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'sessions',
      registrations: 'registrations'
    }
end
