ActiveAdmin.register User do
  permit_params :email, :first_name, :last_name, :approved, :admin, :password, :password_confirmation,
                user_profile_attributes: [:id, :about, :facebook_account, :instagram_account, :telegram_account, :avatar, :cover_image]

  scope 'Все', :all
  scope ('Неподтвержденные')  { |scope| scope.where(approved: false) }

  index do
    selectable_column
    id_column
    column :email
    column :full_name
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :approved
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :email
      f.input :first_name
      f.input :last_name
      if f.object.new_record?
        f.input :password
        f.input :password_confirmation
      end
      if current_user.admin?
        f.input :approved unless f.object.approved
        f.input :admin unless f.object.id == current_user.id
      end

      f.has_many :user_profile, allow_destroy: false, new_record: true do |ff|
        ff.input :about
        ff.input :facebook_account
        ff.input :instagram_account
        ff.input :telegram_account

        hint = ff.object.avatar.present? ? image_tag(ff.object.avatar.url) : content_tag(:span, "Аватар не загружен")
        ff.input :avatar, as: :file, hint: hint, input_html: { :class => 'js_image' }
        if ff.object.avatar.present?
          ff.input "remove_avatar".to_sym, as: :boolean, label: 'Удалить'
          end

        hint = ff.object.cover_image.present? ? image_tag(ff.object.cover_image.url) : content_tag(:span, "Обложка не загружена")
        ff.input :cover_image, as: :file, hint: hint, input_html: { :class => 'js_image' }
        if ff.object.cover_image.present?
          ff.input "remove_cover_image".to_sym, as: :boolean, label: 'Удалить'
        end
        ff.input "cover_image_cache", as: :hidden
      end
    end
    f.actions
  end

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row(field)
      end
    end
    panel UserProfile.model_name.human do
      attributes_table_for user.user_profile do
        row :about
        row :facebook_account
        row :instagram_account
        row :telegram_account
        row :avatar do |up|
          image_tag up.avatar, class: 'img-responsive'
        end
        row :cover_image do |up|
          image_tag up.cover_image, class: 'img-responsive'
        end
      end
    end

    active_admin_comments
  end

end
