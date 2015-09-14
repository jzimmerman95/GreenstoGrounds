class OrderController < ApplicationController
	skip_before_filter  :verify_authenticity_token
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
		
		if params[:ad1]
			@order.alacarte += params[:ad1]
			@order.alacarte += ","
		end	
		
		if params[:ad2]
			@order.alacarte += params[:ad2]
			@order.alacarte += ","
		end	
		if params[:ad3]
			@order.alacarte += params[:ad3]
			@order.alacarte += ","
		end	
		
		if params[:ad4]
			@order.alacarte += params[:ad4]
			@order.alacarte += ","
		end	
		
		if params[:ad5]
			@order.alacarte += params[:ad5]
			@order.alacarte += ","
		end	
		if params[:ad6]
			@order.alacarte += params[:ad6]
			@order.alacarte += ","
		end	
		
		#add comments and discount
		@order.comments = params[:comments]
		@order.code = params[:discount_code]


		#redirect for payment and total the price
		if @order.save
			@order.total_price
			if @order.total < 1
				redirect_to order_complete_path
			
			else 
				redirect_to @order.paypal_url(order_path(@order))
			end
		end
	end
	def show
	end
	def edit
	end
	def new
	end
	def complete
	end

private 

end