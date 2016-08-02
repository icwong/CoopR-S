class AdminController < ApplicationController
  before_action admin!
  
    
  def index
    @users = User.all.order(id: :asc)
  end

  def admin!
  	if !current_user.admin?
      redirect_to root_path
      flash[:notice] = 'insufficient privilege' 
      return      
  	end
  end
end
