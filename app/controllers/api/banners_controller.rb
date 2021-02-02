module Api
  class BannersController < BaseController

    def update_reviewed
      banners = Banner.where(id: params[:banner_ids])

      if banners.exists?
        banners.each do |b|
          b.update_attributes(reviewed: b.reviewed + 1)
        end
      else
        nil
      end

      render json: { message: "Updated", status: 200 }
    end

  end
end
