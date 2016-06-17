class User < ActiveRecord::Base
	has_one :preference

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
         
  devise :zxcvbnable
  # Optionally add more weak words to check against:
  def weak_words
    ['mysitename', self.email, 'password', 'coop']
  end
end
