Rails.application.routes.draw do
  resources :gifs
  get 'welcome/index'

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  get 'search', to: 'gifs#index'
  get 'browse', to: 'gifs#index'

  root 'welcome#index' 
end
