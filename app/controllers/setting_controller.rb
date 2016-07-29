class SettingController < ApplicationController
  before_action :set_config, only: [:display, :update]

  def display
    
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

  def update


  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @profile = Profile.find_by user_id: current_user.id
      @preference = Preference.find_by user_id: current_user.id
    end
end
