class AddIndexToSearchableArticles < ActiveRecord::Migration[5.1]
   disable_ddl_transaction!

  def change
    add_index :articles, :searchable, using: :gin, algorithm: :concurrently
  end
end
