class CreateGifs < ActiveRecord::Migration
  def change
    create_table :gifs do |t|
      t.string :elasticsearch_id, null: false, limit: 20, unique: true, index: true
      t.string :title, null: false, limit: 50
      t.text :description
      t.text :metadata, default: {}
      t.attachment :image, null: false

      t.references :user, index: true

      t.timestamps null: false
    end

    add_foreign_key :gifs, :users
  end
end
