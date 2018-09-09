class ApplicationController < ActionController::Base
	protect_from_forgery with: :exception 

	# call before action on currrent cart in order for:
		# current_cart to be created as soon as first request is made
	before_action :current_cart

	# current cart is available everywhere in the application since every controller
	# inherits from application controller 
	def current_cart
		@current_cart ||= ShoppingCart.new(token: cart_token)
	end

	# makes current_cart method available in the views
	helper_method :current_cart

	private 

	def cart_token
		# return cart token if it is not nil 
		return @cart_token unless @cart_token.nil?

		# if cart session exists then continue, 
 		# if never had a cart token before then we define cart token as a new hash 
		session[:cart_token] ||= SecureRandom.hex(8)
		# take session cart token and assign to instance variable 
		# cart token to make it accessible 	
		@cart_token = session[:cart_token]
	end
end
