class Userontroller < ApplicationController
  
       def new
       	@user = User.new
       	@user.preference.build
       end

       

  # POST /preferences
  # POST /preferences.json
  def create
    @preference = Preference.new(preference_params)

    respond_to do |format|
      if @preference.save
        format.html { redirect_to @preference, notice: 'Preference was successfully created.' }
        format.json { render :show, status: :created, location: @preference }
      else
        format.html { render :new }
        format.json { render json: @preference.errors, status: :unprocessable_entity }
      end
    end
  end
end
