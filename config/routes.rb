Rails.application.routes.draw do
  devise_for :users

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      devise_scope :user do
        post 'sing_up', to: 'registrations#create'
        post 'sing_in', to: 'sessions#create'
        delete 'log_out', to: 'sessions#destroy'
      end

      post 'facebook', to: 'users#facebook'
      resources :books, only: %w[index show] do
        resources :reviews, except: :new
      end
    end
  end
end
