class EmailValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
      record.errors[attribute] << (options[:message] || "is not an email")
    end
  end
end

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         
  devise :zxcvbnable
  # Optionally add more weak words to check against:
  def weak_words
    ['mysitename', self.email, 'password', 'coop']
  end
  
  validates :email, uniqueness: { case_sensitive: false }, email: true
  #validates :email, confirmation: true
	#validates :email_confirmation, presence: true
  
end
