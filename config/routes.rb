Rails.application.routes.draw do
  get '/member-data', to: 'members#show'
  devise_scope :user do
    put 'update', to: 'registrations#update'
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
