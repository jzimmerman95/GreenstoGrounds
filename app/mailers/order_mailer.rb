class OrderMailer < ActionMailer::Base
	default from: "gabecorso@gmail.com"

	def order_submitted_email(order)
		@order = order

		mail(to: "gabecorso@aol.com", subject: "Order Submitted")


		# change to greenstogrounds@gmail
	end


end