class RegistrationsController < Devise::RegistrationsController
  def new
    super
  end

  def create
    super
    if resource.save
      @preference = @user.build_preference;
      @preference.save
    end
  end

  def update
    super
  end
end 
