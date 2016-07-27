class SettingController < ApplicationController
  before_action :set_profile, only: [:show]

  def display
    @profile = Profile.find_by user_id: current_user.id
    @preference = Preference.find_by user_id: current_user.id
    
    if @preference == nil
    	@preference = Preference.new( { "user_id" => current_user.id } )
    	@preference.save()
      format.html { redirect_to "setting", notice: 'Preference created.' }
    else
    	@result = Geocoder.search( @preference.zip )
    	if @result != nil && @result.first != nil
    		@location = @result.first.data
    	end
    end
  end

end
