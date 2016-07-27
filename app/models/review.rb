class Review < Post
	belongs_to :student
	has_one :company

	def self.model_name
		Post.model_name
	end
end
