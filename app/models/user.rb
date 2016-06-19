class User < ActiveRecord::Base
	has_one :preference
  accepts_nested_attributes_for :preference

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  devise :zxcvbnable
  # Optionally add more weak words to check against:
  def weak_words
    ['mysitename', self.email, 'password', 'coop']
  end

  def display_name
    @pf = Preference.find( self.id );
    return ( @pf.nil? || @pf.name.blank? ) ? self.email : @pf.name;
  end
end
