Rails.application.routes.draw do
  get 'home/index'
  get 'home/signup'
  get 'posts/timeline'
  root 'home#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

 # Post routes
 resources :posts do
  resources :comments, only: [:create, :destroy, :edit, :update]
end




  
  post 'signup', to: 'users#create'
  post 'login', to: 'sessions#create'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
