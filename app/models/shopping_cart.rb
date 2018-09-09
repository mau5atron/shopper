class ShoppingCart
	
	# delegate makess sub_total public to specified classes/models
	# when calling subtotal from order, will be able to call sub_total with: current_cart.sub_total
	delegate :sub_total, to: :order 

	# shopping cart will hold all data for our shopping cart
	def initialize(token:)
		# when initalizing shopping cart, will figure out who's shopping cart it belongs to 
		@token = token
	end

	def order
		# if @order instance has been assigned in the past, it will return that instance
		# otherwise a new order token instance will be created
		@order ||= Order.find_or_create_by(token: @token, status: 'cart') do |order|
			order.sub_total = 0
		end
	end

	def items_count
		order.items.sum(:quantity)		
	end

	# will be used in the order items controller 
	def add_item(product_id:, quantity: 1)
		# find product based on product id 
		product = Product.find(product_id)

		# find or create a an order item for that order id
		# find order item based on current order
		order_item = order.items.find_or_initialize_by(
			product_id: product_id
		)

		order_item.price = product.price
		order_item.quantity = quantity

		# save order_item

		# TRANSACTION
		# to avoid having either method not saving 
		# wrap in a transaction block to ensure SQL statements are permanent if 
		# can succeed as one action
		ActiveRecord::Base.transaction do 
			order_item.save
			update_sub_total!
		end
		# TRANSACTION
	end

	def remove_item(id:)
		# TRANSACTION
		ActiveRecord::Base.transaction do 
			order.items.destroy(id)
			update_sub_total!
		end
		# TRANSACTION
	end

	private 

	# update sub_total when updating (removing or adding to current_cart)
	def update_sub_total!
		order.sub_total = order.items.sum('quantity * price')
		order.save
	end
end