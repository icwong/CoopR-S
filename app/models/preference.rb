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
		return !self.provience.nil? || !self.city.nil? || !self.street.nil? || !self.house_number.nil?
	end

	def full_address
		return [ self.house_number, self.street, self.city, self.provience ].join(" ")
	end

	def update_geocode
    	if self.latitude.nil? || self.longitude.nil?
      		if self.has_address
        		if !self.zip.nil?
        			@result = Geocoder.search( self.zip )
       		 	else 
        			@result = Geocoder.search( self.full_address )
        		end

        		if @result != nil && @result.first != nil
    				@location = @result.first.data
    				self.latitude  = @location["geometry"]["location"]["lat"].to_f
    				self.longitude = @location["geometry"]["location"]["lng"].to_f
    				self.save
    			end
    		end
    	end
	end
end
