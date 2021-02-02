class SingleArticleSerializer < BaseArticleSerializer
  attributes(
    :body,
    :author,
    :user,
    :updater,
    :infographic,
    :redaction,
    :publish_on,
    :created_at,
    :updated_at,
    :short_description,
    :origin,
    :translate,
    :tags,
    :tagged_banners
  )

  def id
    object.id.to_s
  end

  def tagged_banners
    object.tagged_banners
  end

end
