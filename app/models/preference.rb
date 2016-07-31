class Preference < ActiveRecord::Base
	belongs_to :user
	self.primary_key = "user_id"
	validates :user_id, presence: true
	
	def has_location
		return !self.latitude.nil? && !self.longitude.nil?
	end

	def has_address
		return !self.zip.nil? || self.has_full_address
	end

	def has_full_address
		return !self.province.nil? || !self.city.nil? || !self.street.nil? || !self.house_number.nil?
	end

	def full_address
        @there = self.house_number || ""

        if !self.street.nil?
            @there = @there + " " + self.street
        end

        if !self.city.nil?
            if @there.blank?
                @there = self.city
            else
                @there = @there + ", " + self.city
            end
        end

        if !self.province.nil?
            if @there.blank?
                @there = self.province
            else
                @there = @there + ", " + self.province
            end
        end

		return @there
	end

    def info
        return [ self.zip, self.full_address ].join("\n")
    end

end
