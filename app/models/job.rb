class Job < ActiveRecord::Base
	belongs_to :post
	has_one :company

	def offered_name
		@user = User.find_by id: self.id
		if @user.nil?
			return "unknown"
		end
		return @user.display_name
	end

	def offered_address
		@pf = Preference.find_by user_id: self.id
		if @pf.nil?
			return "unknown"
		end
		return @pf.info
	end
end
