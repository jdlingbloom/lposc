Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do
    get "login", :to => "devise/sessions#new", :as => :new_user_session
    delete "logout", :to => "devise/sessions#destroy", :as => :destroy_user_session
  end

  resources :uploads, :only => [:index, :create, :destroy]

  resources :photos, :only => [] do
    member do
      get "download"
    end
  end

  resources :reports do
    member do
      get "download"
    end
  end

  authenticate :user do
    mount CarrierWave::PostgresqlTable::RackApp.new => "/uploads"
  end

  root :to => "reports#index"
end
