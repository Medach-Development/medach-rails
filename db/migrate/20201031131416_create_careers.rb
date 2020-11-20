class CreateCareers < ActiveRecord::Migration[5.1]
  def change
    create_table :careers do |t|
      t.boolean :is_approved

      t.string :full_name
      t.string :preferred_position
      t.string :email
      t.string :social_network
      t.string :address
      t.string :competencies
      t.string :skills
      t.string :education
      t.string :attachments
      t.string :resume_link
      t.string :photo_link
      t.text :additional_info
      t.text :scientific_publications
      t.text :professional_experience
      
      t.timestamps
    end
  end
end
