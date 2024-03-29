module Api
  class ArticlesController < BaseController
    impressionist :actions => [:show]

    META_PARAMS = %i(page per_page sort).freeze

    def index
      @articles = type_class.includes(:tags).published.sort_query(sort_params).filter(index_params.except(*META_PARAMS))
      @articles = @articles.tagged_with(['перевод'], exclude: true) if type_class == LongreadArticle
      paginated = @articles.page(params[:page]).per(params[:per_page] || 20)

      render_paginated(paginated)
    end

    def show
      unless type_class.exists?(params[:id])
        render(
          json: { errors: [ { message: "#{type_class.model_name.human} с id = #{params[:id]} не найден" } ] },
          status: 404
        )
      else
        @article = type_class.find(params[:id])
        impressionist(@article)
        render json: @article, serializer: serializer, key_transform: :camel_lower
      end
    end

    def show_fixed
      @articles = type_class.includes(:tags).fixed
      render json: @articles
    end

    def show_random
      @articles = type_class.includes(:tags).where.not(hidden: true).order('RANDOM()').limit(params[:per_page] || 3)
      render json: @articles
    end

    def show_related
      tags = type_class.includes(:tags).find_by(id: params[:id]).tags
      @articles = type_class.includes(:tags).joins(:tags).where(
        tags: {name: tags.pluck(:name)}).where.not(id: params[:id], hidden: true).
        order('RANDOM()').limit(params[:per_page] || 3)
      render json: @articles, each_serializer: related_serializer
    end

    def add_typo
      @article = type_class.find(params[:id])
      typo = ArticleTypo.create(typo_text: params[:typo_text], commentary: params[:commentary], article: @article)
      render json: typo
    end

    def all
      @articles = Article.includes(:tags).where.not(hidden: true).published.sort_query(sort_params).filter(index_params.except(*META_PARAMS))
      paginated = @articles.page(params[:page]).per(params[:per_page] || 20)

      render_paginated(paginated)
    end

    def translated
      @articles = type_class.published.tagged_with(['перевод'])
      paginated = @articles.page(params[:page]).per(params[:per_page] || 20)

      render_paginated(paginated)
    end

    protected

    def type_class
      Article
    end

    def serializer
      SingleArticleSerializer
    end

    def each_serializer
      MultipleArticleSerializer
    end

    def related_serializer
      RelatedArticleSerializer
    end

    def index_params
      params.permit(
        :tag,
        :page,
        :per_page,
        :query,
        :user_id,
        sort: [
          :col,
          :dir
        ]
      )
    end

    def sort_params
      index_params[:sort].to_h.reverse_merge(col: :publish_on, dir: :desc)
    end

    private

    def render_paginated(paginated)
      render(
        json: {
          collection: paginated,
          meta: meta_attributes(paginated)
        },
        serializer: ArticleCollectionSerializer,
        key_transform: :camel_lower
      )
    end
  end
end
