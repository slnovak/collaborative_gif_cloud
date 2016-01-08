Rails.application.routes.draw do
  get 'welcome/index'

  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }

  root 'welcome#index' 
end
