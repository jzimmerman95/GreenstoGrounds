class OrderController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	def index
		@order = Order.new
	end
	def create
		@order = Order.new()

		#add name, email, and phone
		@order.name = params[:name]
		@order.email = params[:email]
		@order.phone = params[:phone]


		#check for produce and snacks
		if params[:produce_box]
			@order.produce = 1
		else
			@order.produce = 0
		end
		if params[:snack_box]
			@order.snack = 1
		else
			@order.snack = 0
		end

		#check for a la carte options
		@order.alacarte = ""
		if params[:oranges]
			@order.alacarte += params[:oranges]
			@order.alacarte += ","
		end	
		if params[:strawberries]
			@order.alacarte += params[:strawberries]
			@order.alacarte += ","
		end	
		if params[:bananas]
			@order.alacarte += params[:bananas]
			@order.alacarte += ","
		end	
		if params[:coffee_beans]
			@order.alacarte += params[:coffee_beans]
			@order.alacarte += ","
		end	
		if params[:pretzels]
			@order.alacarte += params[:pretzels]
			@order.alacarte += ","
		end	
		if params[:almonds]
			@order.alacarte += params[:almonds]
			@order.alacarte += ","
		end	
		if params[:kale]
			@order.alacarte += params[:kale]
			@order.alacarte += ","
		end	
		if params[:peanut_butter]
			@order.alacarte += params[:peanut_butter]
			@order.alacarte += ","
		end	
		if params[:tomatoes]
			@order.alacarte += params[:tomatoes]
			@order.alacarte += ","
		end
		
		#add comments and discount
		@order.comments = params[:comments]
		@order.code = params[:discount_code]


		#redirect for payment
		if @order.save
			redirect_to @order.paypal_url(order_path(@order))
		end
	end
	def show
	end
	def edit
	end
	def new
	end

private 

end