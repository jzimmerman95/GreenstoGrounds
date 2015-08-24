class Order < ActiveRecord::Base
	after_create :send_order_create_email
	

	protected 
	def send_order_create_email
		OrderMailer.order_submitted_email(self).deliver
	end
end
