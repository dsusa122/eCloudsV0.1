class SessionsController < Devise::SessionsController
  # Acá le encuentro su directorio raiz y se lo pongo
  def create
    super

  @root_dir = Directory.where("user_id=? AND directory_path=?",current_user.id,"/")[0]

    session[:current_directory]= @root_dir



  end
end

