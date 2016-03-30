Rails.application.routes.draw do
  root to: 'welcome#index'

  scope '/:locale', locale: /en|sw/ do
    get 'your_profile', to: 'workflow#your_profile'
  end
end
