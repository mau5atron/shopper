class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :title, null: false, limit: 150, null: false
      t.decimal :price, null: false, precision: 15, scale: 2, default: 0
      t.text :description

      t.timestamps

      t.index :title, unique: true
    end
  end
end
