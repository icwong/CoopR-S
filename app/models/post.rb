class Post < ActiveRecord::Base
  enum status: [ :normal, :locked, :blocked, :protected ]

  validates :owner, presence: true

  def owner_name
    return self.get_owner.display_name;
  end

  def get_owner
  	return User.find( self.owner );
  end

  def readable?
  	return (self.status != :blocked ) ? true : false;
  end

end
