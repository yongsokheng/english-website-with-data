class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.string :content
      t.string :link
      t.string :result
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
