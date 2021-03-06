Oats::Application.routes.draw do
  root to: 'static_pages#home'
  resources :employees
  resources :companies
  resources :worktimes
  resources :session_employees, only: [:new, :create, :destroy]
  resources :session_companies, only: [:new, :create, :destroy]
  resources :offices, only: [:create, :destroy, :update]
  match '/company/signup',  to: 'companies#new'
  match '/company/signin',  to: 'session_companies#new'
  match '/company/signout',  to: 'session_companies#destroy', via: :delete
  match '/company/new_employee', to: 'companies#new_employee'
  match '/company/edit_employee/:id', to: 'companies#edit_employee'

  match '/employee/signin',  to: 'session_employees#new'
  match '/employee/signout', to: 'session_employees#destroy', via: :delete
  match '/employee/new_employee/', to: 'employees#new_employee'
  match '/employee/edit_employee/:id', to: 'employees#edit_employee'
  match '/employee/reset_pass/:id', to: 'employees#reset_pass'
  match '/employee/performance/:id', to: 'employees#performance'
  match '/employee/checkin', to: 'worktimes#create', via: :post
  match '/employee/checkout', to: 'worktimes#update', via: :post

  get "static_pages/home"
  get "static_pages/about"
  get "static_pages/contact"
  get "static_pages/terms"
  get "static_pages/privacy"
  get "static_pages/clientsandtestimony"
  get "static_pages/help"
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
