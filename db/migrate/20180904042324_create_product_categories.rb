class CreateProductCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :product_categories do |t|
      t.belongs_to :product, null: false
      t.belongs_to :category, null: false

      t.timestamps
    end

    add_foreign_key :product_categories, :products, name: 'fk_product_categories_to_products'
    add_foreign_key :product_categories, :categories, name: 'fk_product_categories_to_categories'
  end
end
