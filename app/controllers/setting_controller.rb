class SettingController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:view]
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

  def view
    @him = User.find_by id: params[:user_id]
    if @him.nil?
      redirect_to root_path
      flash[:notice] = 'User does not exist' 
      return
    end
    @his = Preference.find_by user_id: params[:user_id]
    @he = Profile.find_by user_id: params[:user_id]
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
      params.require(:user).require(:preference).permit( :name, :zip, :street, :city, :province, :formula,:house_number, :latitude, :longitude )
    end
end
