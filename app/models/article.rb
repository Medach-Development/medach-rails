class Article < ApplicationRecord
  include PgSearch

  is_impressionable :counter_cache => true, :unique => :all

  validates :short_description, length: { maximum: 250 }

  has_many :images

  before_save :delete_whitespace

  acts_as_taggable
  mount_uploader :cover_image, ImageUploader
  mount_uploader :avatar, AvatarUploader

  scope :fixed, -> { where(fixed: true)}
  scope :published, -> { where(["publish_on < ?", Time.zone.now]) }
  scope :newest_first, -> {order("created_at DESC")}

  multisearchable against: [:body, :title, :author, :infographic, :redaction, :short_description, :translate, :origin]
  pg_search_scope :search,
    against: [:body, :title, :author, :infographic, :redaction, :short_description, :origin, :translate],
    using: {
      tsearch: {dictionary: "russian", prefix: true}
    }

  def delete_whitespace
    self.tag_list = self.tag_list.map {|s| s.gsub(/(\#|\s)/, '')}
    self
  end

  def self.article_types
    %w(LongreadArticle BlogArticle NewsArticle)
  end

end
