ActiveAdmin.register Career do
  permit_params(
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

  menu parent: 'Вакансии'
  
  scope 'Все', :all
  scope ('Неподтвержденные') { |scope| scope.where(is_approved: false) }

  index do
    selectable_column
    id_column
    column "ФИО", :full_name do |c|
      link_to c.full_name, admin_career_path(c)
    end
    column "Желаемая позиция", :preferred_position
    column "Электронная почта", :email
    column "Социальная сеть", :social_network
    column "Адрес, метро и тд", :address
    # column :competencies
    # column :skills
    # column :education
    # column :attachments
    column "Резюме", :resume_link
    column "Ссылка на Фото", :photo_link
    # column :additional_info
    # column :scientific_publications
    column "Проф. Навыки", :professional_experience
    column "Подтверждена", :is_approved
  end

  filter :created_at

  form do |f|
    inputs do

      input :is_approved
      input :full_name
      input :preferred_position
      input :email
      input :social_network
      input :address
      input :competencies
      input :skills
      input :education
      input :attachments
      input :resume_link
      input :photo_link
      input :additional_info
      input :scientific_publications
      input :professional_experience

    end

    actions
  end

  show do
    attributes_table do
      default_attribute_table_rows.each do |field|
        row(field)
      end
    end

    active_admin_comments
  end

end
