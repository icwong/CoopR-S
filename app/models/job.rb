class Job < ActiveRecord::Base
	belongs_to :post
	has_one :company

	def offered_name
		puts "\n\n\n\n" + self.offered_by.to_s
		@user = User.find_by id: self.offered_by
		if @user.nil?
			return "unknown"
		end
		return @user.display_name
	end

	def offered_address
		@pf = Preference.find_by user_id: self.offered_by
		if @pf.nil?
			return "unknown"
		end
		return @pf.info
	end
end
