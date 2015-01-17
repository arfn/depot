class Product < ActiveRecord::Base
	has_many :line_items

	before_destroy :ensure_not_referenced_by_any_line_item



	validates_length_of :title, minimum: 10, too_short: 'The title must at least 10 characters'
	validates :title, :description, :image_url, presence: true
	validates :price, numericality: {greater_than_or_equal_to: 0.01}
	validates :title, uniqueness: true
	validates :image_url, allow_blank: true, format: {
		with: %r{\.(gif|jpg|png)\Z}i,
		message: "The image must be Gif, JPG or PNG"
	}

	def self.latest
		Product.order(:updated_at).last
	end

	# ensure theres n referenced by any line item
	def ensure_not_referenced_by_any_line_item
		if line_items.empty?
			return true
		else
			errors.add(:base, 'Line Items Present')
			return false
		end
	end

end
