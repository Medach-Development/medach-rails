class BaseArticleSerializer < ActiveModel::Serializer
  attributes :id, :title, :tags, :cover_image, :views, :publication_date, :author, :type

  def id
    object.id.to_s
  end

  def views
    object.impressions_count
  end

  def tags
    object.tag_list
  end

  def cover_image
    { url: object.cover_image.url }
  end

  def publication_date
    object.publish_on
  end

  def type
    case object.type
    when 'LongreadArticle'
      'Article'
    when 'BlogArticle'
      'Blog'
    when 'NewsArticle'
      'News'
    when 'Article'
      'BaseArticle'
    else
      'Unknown'
    end
  end

end