ActiveAdmin.register Event do

  actions :index, :show

  index do
    column :id
    column :code
    column :event_date
    column :execution_id
    column :created_at

    default_actions
  end
end
