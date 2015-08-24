class OrderMailer < ActionMailer::Base
	default from: "gabecorso@gmail.com"

	def order_submitted_email(order)
		@order = order
		mail(to: "jessicazimmerman95@gmail.com", subject: "Order Submitted")
	end


end