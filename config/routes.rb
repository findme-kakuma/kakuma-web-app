Rails.application.routes.draw do
  if Rails.env.development?
    require 'que/web'
    mount Que::Web => '/que'
  end

  # constraints subdomain: 'admin' do
  #   scope module: 'admin', as: 'admin' do
  #     root to: 'residents#index'
  #     resources :countries, only: :index
  #     resources :residents, only: [:index, :destroy]
  #   end
  # end

  root to: 'welcome#index'

  scope '(:locale)', locale: /en|sw/ do
    resources :workflow, only: [:show, :update]
    post '/workflow/:id', to: 'workflow#create'
    resources :residents, only: [:show]

    namespace 'admin' do
      root to: 'residents#index'
      resources :countries, only: :index
      resources :residents, only: [:index, :destroy]
    end
  end
end
