class MainController < ApplicationController
  skip_before_action :authenticate_user!
  
       def index
       		@me = current_user;
       end
end
