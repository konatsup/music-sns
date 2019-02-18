class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :comment
      t.string :artist
      t.string :album
      t.string :track
      t.string :image_url
      t.string :music_url
      t.timestamps null: false
      t.references :user
    end
  end
end
