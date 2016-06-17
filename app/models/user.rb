class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable, :lockable, :timeoutable
         
         
  devise :zxcvbnable
  # Optionally add more weak words to check against:
  def weak_words
    ['mysitename', self.email, 'password', 'coop']
  end
  def timeout_in
    if self.admin? 
      1.hour
    else
      30.minutes
    end
  end
end
