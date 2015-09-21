class Order < ActiveRecord::Base
	#after_create :send_order_create_email

	dectotal = 0
	def paypal_url(return_path)
		values = {
			business: "greenstogrounds@gmail.com",
			cmd: "_xclick",
			upload: 1,
			#return: "#{Rails.application.secrets.app_host}#{return_path}",
			return: "greenstogrounds.herokuapp.com",
			invoice: id,

			#calculate dectotal price in dollars
			amount: self.dectotal,

			#concatenate order options
			item_name: "Produce Boxes: #{self.produce}, Snack Boxes: #{self.snack}, A La Carte: #{self.alacarte}",
			
			quantity: '1',
			notify_url: "#{Rails.application.secrets.app_host}/hook"
		}
		"#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
	end




	#tally up dectotal price
	def total_price()
		self.dectotal = 0


		#check for box item and snack item
		if self.produce == 1
			self.dectotal += 10
		end
		if self.snack == 1
			self.dectotal += 10
		end

		if self.alacarte.include? "Beef"
			self.dectotal += 6.5
		end
		if self.alacarte.include? "Cider"
			self.dectotal += 4.5
		end
		if self.alacarte.include? "Granola"
			self.dectotal += 4.5
		end
		if self.alacarte.include? "Eggs"
			self.dectotal += 2.5
		end
		if self.alacarte.include? "Pears"
			self.dectotal += 3
		end
		if self.alacarte.include? "Grapes"
			self.dectotal += 3.5
		end
		#check alacarte items
		#check for discount
		if self.code == "eatyourvegetables"
			self.dectotal = 0
		end


	end
	

	protected 
	def send_order_create_email
		OrderMailer.order_submitted_email(self).deliver
	end
end
