class Article < ApplicationRecord
  include PgSearch
  include Filterable
  include Sortable

  is_impressionable :counter_cache => true, :unique => :all

  validates :short_description, length: { maximum: 250 }

  has_many :images

  before_save :delete_whitespace

  acts_as_ordered_taggable
  mount_uploader :cover_image, CoverImageUploader
  mount_uploader :avatar, AvatarUploader
  mount_uploader :small_cover_image, SmallCoverImageUploader

  scope :fixed, -> { where(fixed: true) }
  scope :published, -> { where('publish_on < ?', Time.current) }
  scope :newest_first, -> { order(created_at: :desc) }

  multisearchable against: [:title, :author, :short_description, :origin]
  pg_search_scope :search,
    against: [:title, :author, :short_description, :origin],
    associated_against: { :tags => [:name] },
    using: {
      tsearch: { dictionary: 'russian', prefix: true }
    }

  def delete_whitespace
    self.tag_list = self.tag_list.map {|s| s.gsub(/(\#|\s)/, '')}
    self
  end

  def self.article_types
    %w(LongreadArticle BlogArticle NewsArticle)
  end

  def tag_string=(value)
    self.tag_list = value
  end

  def tag_string
    self.tag_list.join(', ')
  end

end
