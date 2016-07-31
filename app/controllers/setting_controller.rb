class SettingController < ApplicationController
  before_action :set_config, only: [:display, :update]

  def display
    if @preference.nil?
    	@preference = Preference.new( { "user_id" => current_user.id } )
    	@preference.save()
      respond_to do |format|
        format.html { redirect_to setting_path, notice: 'Preference created.' }
      end
    end
  end

  def update
    @result = ""
    if !@profile.nil? && @profile.update(pro_params)
      @result = "Profile updated \t"
    end
    if !@preference.nil? && @preference.update(pre_params)
      @result = @result + "Preference updated \t"
    end

    if @result == ""
      @result = "something wrong"
    end
    respond_to do |format|
      format.html { redirect_to setting_path, notice: @result }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_config
      @me = current_user
      @profile = Profile.find_by user_id: current_user.id
      @preference = Preference.find_by user_id: current_user.id
    end

    def pro_params
      params.require(:user).require(:profile).permit(:phone)
    end

    def pre_params
      params.require(:user).require(:preference).permit( :name, :zip, :street, :city, :province, :house_number, :latitude, :longitude )
    end
end
