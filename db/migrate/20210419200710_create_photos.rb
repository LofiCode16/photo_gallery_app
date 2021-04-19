class CreatePhotos < ActiveRecord::Migration[5.2]
  def change
    create_table :photos do |t|
      t.string :description
      t.string :location, default: 'somewhere...'
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
