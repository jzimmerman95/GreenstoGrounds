class OrderMailer < ActionMailer::Base
	default from: "gabecorso@gmail.com"

	def order_submitted_email(order)
		@order = order
<<<<<<< HEAD
		mail(to: "jessicazimmerman95@gmail.com", subject: "Order Submitted")
=======
		mail(to: "gabecorso@aol.com", subject: "Order Submitted")
>>>>>>> 51517ef292a133b70b776ee2bf96931b559dba26

		# change to greenstogrounds@gmail
	end


end