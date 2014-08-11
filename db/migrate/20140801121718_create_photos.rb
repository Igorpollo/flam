class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.references :album, index: true
      t.references :user, index: true
      t.string :title
      t.text :description
      t.string :photo_token

      t.timestamps
    end
    add_attachment :photos, :path
  end
end
