class Userontroller < ApplicationController
  
       def new
       	@user = User.new
       	@user.preference.build
       end
end
