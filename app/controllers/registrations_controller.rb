class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    @preference = Preference.new( params[:name] )

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

  def update
    super
  end
end 
