class Order < ActiveRecord::Base
	after_create :send_order_create_email

	total = 0
	def paypal_url(return_path)
		values = {
			business: "greenstogrounds@gmail.com",
			cmd: "_xclick",
			upload: 1,
			#return: "#{Rails.application.secrets.app_host}#{return_path}",
			return: "greenstogrounds.herokuapp.com",
			invoice: id,

			#calculate total price in dollars
			amount: self.total,

			#concatenate order options
			item_name: "Produce Boxes: #{self.produce}, Snack Boxes: #{self.snack}, A La Carte: #{self.alacarte}",
			
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

		if self.alacarte.include? "Peaches"
			self.total += 5
		end
		if self.alacarte.include? "Doughnuts"
			self.total += 5
		end
		if self.alacarte.include? "Granola"
			self.total += 4
		end
		if self.alacarte.include? "Chorizo"
			self.total += 6
		end
		if self.alacarte.include? "Basil"
			self.total += 1
		end
		if self.alacarte.include? "Tomatoes"
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
