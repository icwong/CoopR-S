class SettingController < ApplicationController

  def display
      @me = current_user
      @profile = Profile.find_by user_id: current_user.id
      @preference = Preference.find_by user_id: current_user.id
    
    if @preference.nil?
    	@preference = Preference.new( { "user_id" => current_user.id } )
    	@preference.save()
      format.html { redirect_to setting_path, notice: 'Preference created.' }
    end
  end

  def update
      @me = current_user
      @profile = Profile.find_by user_id: current_user.id
      @preference = Preference.find_by user_id: current_user.id

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

    def pro_params
      params.require(:user).require(:profile).permit(:phone)
    end

    def pre_params
      params.require(:user).require(:preference).permit( :name, :zip, :street, :city, :province, :house_number, :latitude, :longitude )
    end
end
