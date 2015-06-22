Rails.application.routes.draw do
  resources :ppls

  resources :zbozis

  resources :customers  do
    resources :poznamkas
  end
  
  resources :poznamkas
  
  resources :customers  do
    resources :nakups
  end
  
  resources :customers  do
    resources :dluhs
  end

 resources :customers  do
    resources :ppls
  end
  resources :nakups
  resources :dluhs

  resources :uzivatels
  
  match 'nakups/add-zbozi', to: 'nakups#addZbozi', :via => :post
  match 'nakups/zpet', to: 'nakups#cleanNakup', :via => :post
  match 'nakups/add-zbozi-edit', to: 'nakups#addZboziFromEdit', :via => :post 
  match 'nakups/edit-zbozi', to: 'nakups#updateZboziFromNakup', :via => :post
  match 'nakups', to: 'nakups#index', :via => :get
  
  match 'customers/createfromppls', to: 'customers#createfromppls', :via => :post
  match 'customers/changeRating', to: 'customers#changeRating', :via => :post
  
  resources :ppls, only: [] do
    get :autocomplete_customer_prijmeni, :on => :collection
  end 
  get 'ppls/autocomplete_customer_prijmeni'
  
  get 'access/index'
  get 'access/login'
 
  get 'access/attempt_login', :to => 'access#attempt_login'
  post 'access/attempt_login', :to => 'access#attempt_login'
  get 'access/zapomenute_heslo', :to => 'access#zapomenute_heslo'
  post 'access/nove_heslo', :to=> 'access#nove_heslo'
  
  match 'access/logout', :to => 'access#logout', :via => [:get, :post]
 
  root 'access#index'
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
