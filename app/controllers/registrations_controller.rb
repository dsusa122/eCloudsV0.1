class RegistrationsController < Devise::RegistrationsController

  def create
    super
    # Cada vez que creo un un usuario le pongo su directorio raiz
    @root_dir = Directory.new
    @root_dir.name = ""
    @root_dir.directory_path =  "/"
    @root_dir.user_id = resource.id
    @root_dir.save


  end


end
