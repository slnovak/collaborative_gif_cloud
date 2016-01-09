Rails.application.routes.draw do
  resources :gifs
  get 'welcome/index'

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  root 'welcome#index' 
end
