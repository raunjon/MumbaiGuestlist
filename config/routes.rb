Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
    #default_url_options :host => "https://mumbaiguestlist.herokuapp.com"
    default_url_options :host => "http://localhost:3000"
  # You can have the root of your site routed with "root"
  root 'guestlists#index'
  get 'clubs', to: 'clubs#index'
  get '/mgl', to: redirect('/clubs#index')
  # get 'login', to: "/auth/facebook"
 # post 'login', to: "auth/facebook"
  delete 'logout', to: 'sessions#destroy'

    get 'api/auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    get 'signout', to: 'sessions#destroy', as: 'signout'
    get 'loginUser', to: 'sessions#index'

    resources :sessions, only: [:create, :destroy]
    resource :home, only: [:show]

  resources :guestlists

  # , constraints: { subdomain: 'api' }

    namespace :api, :defaults => {:format => :json} do
      resources :clubs
      resources :guestlists
      get 'loginUser', to: 'sessions#index'
      get 'signout', to: 'sessions#destroy', as: 'signout'
      post 'guestlists/new', to: 'guestlists#create'
      post 'auth/:provider/callback', to: 'sessions#create'
      post 'auth/failure', to: redirect('/')
      delete 'signout', to: 'sessions#destroy'
    end

    namespace :admin do
    resources :clubs
    resources :guestlists
    get '/guestlists/?status=:status', to: 'guestlists#index', as: "status_params"
    get '/guestlists/?date=:date', to: 'guestlists#index', as: "date_params"

    resources :users
    get '/', to: redirect('admin/clubs#index')
    get 'login', to: 'sessions#new'
    post 'login', to: 'sessions#create'
    delete 'logout', to: 'sessions#destroy'
end
  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
