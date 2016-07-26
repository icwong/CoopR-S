class Profile < ActiveRecord::Base
    belongs_to :user
	self.primary_key = "user_id"
	validates :user_id, presence: true
	
	 delegate :first_name, to: :user, allow_nil: true, prefix: true
end
