Rails.application.routes.draw do
  resources :authentications
  resources :histories
  resources :profiles
  resources :tags
  root 'main#index'
  get 'admin' => 'admin#index'
  get 'index' => 'main#index'
  get 'text' => 'main#dummy'
  get 'edit' => 'main#editor'
  get 'compare' => 'main#compare'
  get 'home' => 'main#home'
  get 'mail' => 'authentications#mail'
  get 'verify' => 'authentications#verify'
  get 'compare' => 'main#compare'
  get 'resume' => 'resumes#index'
  get 'resume/:id/show' => 'resumes#show', :as => 'show_resume'
  resources :posts
  resources :preferences
  resources :resumes do
    collection do
      get 'search'
    end
  end
  devise_for :users, :controllers => {:registrations => "registrations"}
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):

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
