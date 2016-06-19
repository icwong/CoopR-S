class Company < User
  def display_name
    return "©" + super;
  end
end
