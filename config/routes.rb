Rails.application.routes.draw do
  get '/member-data', to: 'members#show'
  resources :courses
  resources :course_registrations
  resources :terms
  resources :term_registrations
  resources :rooms
  resources :room_registrations
  devise_scope :user do
    put 'update', to: 'updates#update_user'
    put 'passupdate', to: 'updates#update_password'
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
