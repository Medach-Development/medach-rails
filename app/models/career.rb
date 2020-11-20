class Career < ApplicationRecord
  validates_format_of :email, :with => /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i

  scope :approved, -> { where(is_approved: true) }
end
