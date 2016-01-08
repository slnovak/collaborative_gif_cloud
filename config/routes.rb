Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'user/sessions'
  }
end
