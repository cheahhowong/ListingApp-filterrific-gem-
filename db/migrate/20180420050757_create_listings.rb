class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.string :listings
      t.references :user, foreign_key: true
      t.string :title
      t.string :country
      t.integer :num_beds
      t.integer :num_bath
      t.integer :price_per_night

      t.timestamps
    end
  end
end
