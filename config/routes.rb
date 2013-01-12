Lagrange::Application.routes.draw do
  root :to => 'problems#index'
  resources :problems, :only => :show
end
