class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :title
      t.text :content
      t.string :image
      t.integer :view
      t.string :audio_url
      t.string :post_status
      t.datetime :published_at
      t.datetime :schedule_at
      t.datetime :deleted_at, index: true
      t.references :category, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
