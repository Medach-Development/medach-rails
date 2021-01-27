class Banner < ApplicationRecord
	# belongs_to :article
	
	enum positions: {
		top: "top",
		right: "right",
		bottom: "bottom",
		left: "left",
		in_text: "in_text"
	}
	
	validates :url, presence: true	
	validates :image, presence: true
	validates :position, presence: true

  acts_as_ordered_taggable

	mount_uploader :image, BannerUploader
end
