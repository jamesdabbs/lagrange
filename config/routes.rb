Lagrange::Application.routes.draw do
  root :to => 'problems#index'

  resources :problems, :only => :show do
    resources :solutions, :only => [:show, :update]
  end
end
