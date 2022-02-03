class AddSearchableColumnToArticles < ActiveRecord::Migration[5.1]
  def up
    execute <<-SQL
      ALTER TABLE articles
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('russian', coalesce(title, '')), 'A') ||
        setweight(to_tsvector('russian', coalesce(short_description, '')), 'B') ||
        setweight(to_tsvector('russian', coalesce(author, '')), 'C') ||
        setweight(to_tsvector('russian', coalesce(origin, '')), 'D') ||
        setweight(to_tsvector('russian', coalesce(body, '')), 'D')
      ) STORED;
    SQL
  end

  def down
    remove_column :articles, :searchable
  end
end
        # setweight(to_tsvector('russian', coalesce(author, '')), 'C') ||
        # setweight(to_tsvector('russian', coalesce(origin, '')), 'D') ||
        # setweight(to_tsvector('russian', coalesce(body, '')), 'E')
        # ||
        # setweight(to_tsvector('russian', coalesce(short_description, '')), 'B')