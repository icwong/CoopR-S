class Profile < ActiveRecord::Base
    belongs_to :user
	self.primary_key = "user_id"
	validates :user_id, presence: true

	def get_img
		if !self.avatar.nil?
			return "uploads/" + self.avatar
		end
	end

end
