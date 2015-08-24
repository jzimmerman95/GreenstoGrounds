class OrderController < ApplicationController
	before_action :set_order, only: [:show, :edit, :update, :destroy]
	def index
		@order = Order.new
	end
	def create
		@order = Order.new()
		@order.name = params[:name]
		@order.email = params[:email]
		@order.phone = params[:phone]
		@order.alacarte = params[:oranges]
		@order.alacarte += params[:strawberries]
		@order.alacarte += params[:bananas]


		if @order.save

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