ActiveAdmin.register Banner do

  permit_params(
    :title,
    :url,
    :description,
    :position,
    :image,
    :image_cache,
    :tag_list,
    :reviewed,
    :visible
  )

  index do
    selectable_column
    id_column
    column 'Заголовок', :title do |v|
      link_to v.title, admin_banner_path(v)
    end
    column :description
    column 'Теги', :tag_list
    column :url
    column :position
    column :reviewed
    column :visible
  end

  filter :created_at


  form do |f|
    render partial: "admin/banner_image_uploader", locals: { f: f, label: 'Изображение для баннера', name: "image", message: "Миниатюра изображения не представлена" }
    inputs do
      input :title
      input :description
      input :tag_list, label: 'Теги'
      input :url
      input :position, label: 'Позиция', as: :select, collection: Banner.positions.keys
      input :visible, label: 'Активнен'
    end

    actions
  end

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row(field)
      end
    end
  end

end
