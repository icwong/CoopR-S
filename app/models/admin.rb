class Admin < User
  def display_name
    return "Administrator";
  end
	
  def admin?
    return true;
  end
end
