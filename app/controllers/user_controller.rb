class Userontroller < ApplicationController
  
       def new
       	@user = User.new
       	@user.preference.build
       end

       

  # POST /preferences
  # POST /preferences.json
  def create
  end
end
