class CreateCategoryListings < ActiveRecord::Migration[8.0]
  def change
    create_table :category_listings do |t|
      t.references :category, null: false, foreign_key: true
      t.references :listing, null: false, foreign_key: true

      t.timestamps
    end
  end
end
