class AddReviewedAndVisibleToBanners < ActiveRecord::Migration[5.1]
  def change
    add_column :banners, :reviewed, :bigint, default: 0
    add_column :banners, :visible, :boolean, default: true
  end
end
