ActiveAdmin.register Article do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :body, :image, :title, :author, :infographic, :redaction, :created_at, :tag_list, :publish_on, :shorttext
#
# or
#

  show do
    attributes_table do
      row :title
      row :body
      row :image do |ad|
        image_tag(ad.image.url) if ad.image&.url
      end
      row :tag_list
      row :author
      row :redaction
      row :infographic
      row :created_at
      row :publish_on
      row :shorttext
    end
    active_admin_comments
  end

  index do
    column :image do |i|
      image_tag i.image
    end
    column :title
    column :shorttext
    column :body
    column :tag_list
    column :author
    column :redaction
    column :infographic
    column :created_at
    column :publish_on
    actions
  end

  form do |f|
    f.object.publish_on = Time.zone.now
    f.inputs do
      f.input :title, label: "Заголовок"
<<<<<<< Updated upstream
      f.input :body, label: "Статья", as: :quill_editor,input_html: {data: {options: {modules: {toolbar: [['bold', 'italic', 'underline'], ['link', 'image']]}, theme: 'snow'}}}
=======
      f.inputs "Статья" do 
        "<div id=\"article_body\">
        #{f.object.body}
        </div>".html_safe
      end
>>>>>>> Stashed changes
      f.input :image
      f.input :shorttext, label: "Краткое описание"
      f.input :tag_list, :placeholder => 'Теги через запятую'
      f.input :author, label: "Автор"
      f.input :redaction, label: "Редакция"
      f.input :infographic, label: "Инфографика"
      f.input :created_at
      f.input :publish_on, label: "отложенный постинг"
    end
    f.actions
  end
end
