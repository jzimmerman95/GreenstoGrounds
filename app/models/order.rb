class Order < ActiveRecord::Base
	#after_create :send_order_create_email
	total = 0
	def paypal_url(return_path)
		values = {
			business: "greenstogrounds@gmail.com",
			cmd: "_xclick",
			upload: 1,
			return: "#{Rails.application.secrets.app_host}#{return_path}",
			invoice: id,

			#calculate total price in dollars
			amount: self.total,

			#concatenate order options
			item_name: "Your GreensToGrounds Order",
			
			quantity: '1',
			notify_url: "#{Rails.application.secrets.app_host}/hook"
		}
		"#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
	end




	#tally up total price
	def total_price()
		self.total = 0


		#check for box item and snack item
		if self.produce == 1
			self.total += 10
		end
		if self.snack == 1
			self.total += 10
		end

		if self.alacarte.include? "meats"
			self.total += 9
		end
		if self.alacarte.include? "csnacks"
			self.total += 5
		end
		if self.alacarte.include? "sweets"
			self.total += 5
		end
		if self.alacarte.include? "extra"
			self.total += 5
		end
		#check alacarte items
		#check for discount
		if self.code == "eatyourvegetables"
			self.total = 0
		end


	end
	

	protected 
	def send_order_create_email
		OrderMailer.order_submitted_email(self).deliver
	end
end
