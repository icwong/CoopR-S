class Post < ActiveRecord::Base
  validates :owner, presence: true

  def owner_name
    return self.get_owner.display_name;
  end

  def get_owner
  	return User.find( self.owner );
  end
end
