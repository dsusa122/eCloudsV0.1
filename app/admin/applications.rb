ActiveAdmin.register Application do
  index do
    column :id
    column :name
    column :created_at
    column :version
    default_actions
  end

  controller do
    def new
      redirect_to :controller => "/applications", :action => 'new'
    end
  end
end
