class Student < User
	has_many :posts, foreign_key: 'user_id'
	
  def editor?
    @auth = Authentication.find_by user_id: self.id;
    return ( !@auth.nil? && @auth.pass );
  end
end
