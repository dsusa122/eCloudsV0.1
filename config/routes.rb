ECloudsV01::Application.routes.draw do



  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  resources :virtual_machine_events

  #resources
  resources :directories
  resources :cloud_files
  resources :instance_types
  resources :operating_systems
  resources :virtual_machines
  resources :clusters  do
    resources :virtual_machines
    member do
      post :add_virtual_machines
    end
  end

  devise_for :users, :controllers => { :registrations => "registrations" , :sessions => "sessions"}

  devise_scope :user do
    delete "users/sign_out"  => "devise/session#destroy"
  end

  root :to => "static_pages#home"



  get "static_pages/home"

  get "static_pages/help"

  get "static_pages/about"


  #get "browser/browse"
  get "browser/index"

  match "browse/index" => "browser#index" , :as =>  "data_home"


  #rutas para browsear directorios

  match "browse/:directory_id" => "browser#browse", :as => "browse"
  match "browse/:directory_id/new_folder" => "directories#new", :as => "new_sub_directory"

  match "browse/:directory_id/new_file" => "cloud_files#new", :as => "new_sub_file"

  match "browse/:directory_id/rename" => "directories#edit", :as => "rename_directory"

  #rutas para acciones con máquinas virtuales
  # acá puse el current cluster para saber a qué cluster toca devolverse
  match "virtual_machines/:virtual_machine_id/stop/:current_cluster_id"  => "virtual_machines#stop", :as => "stop_virtual_machine"
  match "virtual_machines/:virtual_machine_id/start/:current_cluster_id"  => "virtual_machines#start", :as => "start_virtual_machine"
  match "virtual_machines/:virtual_machine_id/reboot/:current_cluster_id"  => "virtual_machines#reboot", :as => "reboot_virtual_machine"
  match "virtual_machines/:virtual_machine_id/terminate/:current_cluster_id"  => "virtual_machines#terminate", :as => "terminate_virtual_machine"

  match "virtual_machines/start_all/:current_cluster_id"  => "virtual_machines#start_all", :as => "start_all_virtual_machine"
  match "virtual_machines/reboot_all/:current_cluster_id"  => "virtual_machines#reboot_all", :as => "reboot_all_virtual_machine"
  match "virtual_machines/stop_all/:current_cluster_id"  => "virtual_machines#stop_all", :as => "stop_all_virtual_machine"
  match "virtual_machines/terminate_all/:current_cluster_id"  => "virtual_machines#terminate_all", :as => "terminate_all_virtual_machine"


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
