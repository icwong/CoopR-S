class Company < User
  def display_name
    @pf = Preference.find_by user_id: self.id;
    return ( @pf.nil? || @pf.name.blank? ) ? self.email : self.email.split(/@/).first + "©" + @pf.name;
  end
end
