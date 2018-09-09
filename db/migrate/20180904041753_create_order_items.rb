class CreateOrderItems < ActiveRecord::Migration[5.2]
  def change
    create_table :order_items do |t|
    	t.belongs_to :order, null: false
    	t.belongs_to :product, null: false
      t.integer :quantity, null: false, default: 0
      t.decimal :price, null: false, precision: 15, scale: 2

      t.timestamps
    end

    add_foreign_key :order_items, :orders, name: 'fk_order_items_to_order'
    add_foreign_key :order_items, :products, name: 'fk_order_items_to_product'
  end
end
