Rails.application.routes.draw do
  get '/member-data', to: 'members#show'
  get '/users', to: 'users#show'
  resources :courses
  put '/courses', to: 'courses#update_course'
  resources :course_registrations
  resources :terms
  resources :term_registrations
  resources :rooms
  resources :room_registrations
  devise_scope :user do
    put 'update', to: 'updates#update_user'
    put 'passupdate', to: 'updates#update_password'
    put 'roleupdate', to: 'updates#update_user_role'
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
