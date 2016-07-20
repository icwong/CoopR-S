class SettingController < ApplicationController
  before_action :set_profile, only: [:show]

  def display
    @location = Geocoder.search("V6R1P6")
    @profile = Profile.find( current_user.id )
    @preference = Preference.find( current_user.id )
  end

end
