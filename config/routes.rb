Rails.application.routes.draw do
  devise_for :users, ActiveAdmin::Devise.config
  root 'home#index'
  ActiveAdmin.routes(self)
  namespace :api do
    resources :articles, only: [:index, :show] do
      member do
        get 'show_related'
      end
      collection do
        get 'show_fixed'
        get 'show_random'
        get 'translated'
        get 'all'
        %w(news media blogs longread_articles cases).each do |type|
          get type, to: "#{type}#index"
        end
      end 
    end
    resources :images
    resources :documents
    resources :longread_articles, only: :index do
      collection do
        get 'translated'
      end
    end
    resources :blogs, only: :index do
      collection do
        get 'translated'
      end
    end
    resources :news, only: :index do
      collection do
        get 'translated'
      end
    end
    resources :media, only: :index do
      collection do
        get 'translated'
      end
    end
    resources :cases, only: :index do
      collection do
        get 'translated'
      end
    end
    resources :tags, only: [:index, :show] do
      collection do
        get 'most_used', action: :most_used
      end
    end
    resources :users, only: :show do
      resources :blogs, only: :index
    end
    get 'all_articles', to: 'articles#all'
    get 'blogs_page_config', to: 'blogs_configs#index'
    get 'main_page_config', to: 'main_configs#index'
    get 'bloggers', to: 'users#bloggers'
  end
  get '*path' => 'home#index'
end
