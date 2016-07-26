class SettingController < ApplicationController
  before_action :set_profile, only: [:show]

  def display
    @profile = Profile.find_by user_id: current_user.id
    if @profile == nil
    	@profile = Profile.new( { "user_id" => current_user.id } )
    	@profile.save()
    end
    @preference = Preference.find_by user_id: current_user.id
    if @preference != nil
    	@result = Geocoder.search( @preference.zip )
    	if @result != nil && @result.first != nil
    		@location = @result.first.data
    	end
	end
  end

end
