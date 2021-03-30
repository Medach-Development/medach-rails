module Api
  class CareersController < BaseController
    # before_action :set_career, only: [:respond]

    def show
      @career = Career.find_by(id: params[:id])
      if @career
        render json: @career
      else
        head 404
      end
    end

    def index
      @careers = Career.approved
      # paginated = @careers.page(params[:page]).per(params[:per_page] || 20)
      render json: @careers
      # render(
        # json: {
          # collection: paginated,
          # meta: meta_attributes(paginated)
        # },
        # serializer: VacancyCollectionSerializer,
        # key_transform: :camel_lower
      # )
    end

    def create
      @career = Career.new(career_params)
      if @career.save
        render json: @career
      else
        render json: @career.errors, status: :unprocessable_entity
      end
    rescue => e
      render json: { message: e.message }
    end

    # def respond
      # @response = VacancyResponse.new(vacancy_response_params)
      # @response.vacancy = @vacancy
      # if @response.save
        # render json: @response
      # else
        # render json: @response.errors, status: :unprocessable_entity
      # end
    # rescue => e
      # render json: { message: e.message }
    # end

    # def subscribe
      # @subscriber = Subscriber.new(subscribe_params)
      # if @subscriber.save
        # render json: @subscriber
      # else
        # render json: @subscriber.errors, status: :unprocessable_entity
      # end
    # rescue => e 
      # render json: { message: e.message }
    # end

    # def unsubscribe
      # @subscriber = Subscriber.find(params[:subscriber_id])
      # if @subscriber.update(is_subscribed: false)
        # render json: @subscriber
      # else
        # render json: @subscriber.errors, status: :unprocessable_entity
      # end
    # rescue => e
      # render json: { message: e.message }
    # end

    private

    # def set_career
      # @career = Career.find(params[:id])
    # rescue => e
      # render json: { message: e.message }
    # end

    def career_params
      params.permit(
        :is_approved,
        :full_name,
        :preferred_position,
        :email,
        :social_network,
        :address,
        :competencies,
        :skills,
        :education,
        :attachments,
        :resume_link,
        :photo_link,
        :additional_info,
        :scientific_publications,
        :professional_experience
      )
    end

    # def vacancy_response_params
      # params.permit(
        # :full_name,
        # :phone,
        # :email,
        # :covering_letter,
        # :document_id
      # )
    # end

    # def subscribe_params
      # params.permit(
        # :email
      # )
    # end
  end
end
