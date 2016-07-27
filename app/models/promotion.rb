class Promotion < Post
	belongs_to :company
	has_one :company

	def self.model_name
		Post.model_name
	end
end
