Rails.application.routes.draw do

  namespace :admin do
    resources :users
  end
  root to: 'welcome#index'

  resources :tasks do
    post :import, on: :collection
  end


  # get    '/tasks',  to: 'tasks#index'
  # get    '/tasks/:id',  to: 'tasks#show'
  # get    '/tasks/new,  to: 'tasks#new'
  # post    '/tasks/create,  to: "tasks#create"
  # get    '/tasks/:id/edit,  to: "tasks#edit"
  # patfh    '/tasks/:id,  to: "tasks#update"
  # delete    '/tasks/:id,  to: "tasks#destroy"

  get    '/login',        to: 'sessions#new'
  # get    '/session/new',  to: 'sessions#new'
  post   '/login',  to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get    '/signup', to: 'users#new'

  # letter opener web
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?
end
