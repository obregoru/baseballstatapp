class CreatePhotos < ActiveRecord::Migration
  def change
    create_table :photos do |t|
      t.string :photo_name
      t.string :file_name
      t.references :imageable, polymorphic: true

      t.timestamps
    end
  end
end
