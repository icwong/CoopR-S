class Job < ActiveRecord::Base
	belongs_to :post
	has_one :company
end
