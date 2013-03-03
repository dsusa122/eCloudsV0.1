class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @executions=Execution.find_all_by_user_id(params[current_user.id])
    else
      @applications=Application.all
    end
  end

  def help
  end

  def about
  end

end
