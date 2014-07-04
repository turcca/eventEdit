Evented::Application.routes.draw do
  resources :advice_contents
  
  resources :advice_content_advices, :controller => 'advice_contents'
  resources :advice_content_roots, :controller => 'advice_contents'

  resources :secondary_prereqs

  resources :filters

  devise_for :users
  
  resources :chosen_parameters

  resources :chosen_tools

  resources :parameter_values

  resources :parameter_types

  resources :parameters

  resources :pre_tool_associations

  resources :tools

  resources :contents
  
  resources :content_texts, :controller => 'contents'
  resources :content_choices, :controller => 'contents'
  #resources :content_roots, :controller => 'contents'
  resources :content_effects, :controller => 'contents'
  resources :content_outcomes, :controller => 'contents'

  resources :probabilities
  
  resources :users

  resources :chosen_filters
  
  resources :chosen_outcomes
  
  resources :secondary_chosen_outcomes
  
  resources :secondary_prereqs

  resources :events do
    get 'download', on: :collection
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  root 'events#index'

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
