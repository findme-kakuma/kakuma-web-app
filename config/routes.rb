Rails.application.routes.draw do
  constraints subdomain: 'admin' do
    scope module: 'admin', as: 'admin' do
      root to: 'residents#index'
      resources :countries
      resources :residents
    end
  end

  root to: 'welcome#index'

  scope '/:locale', locale: /en|sw/ do
    resources :workflow, only: [:show, :update]
    post '/workflow/:id', to: 'workflow#create'
  end
end
