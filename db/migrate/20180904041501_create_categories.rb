class CreateCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :categories do |t|
      t.string :title, null: false
      t.decimal :price, null: false, precision: 15, scale: 2

      t.timestamps
    end
  end
end
