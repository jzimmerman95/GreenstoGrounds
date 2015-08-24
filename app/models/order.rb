class Order < ActiveRecord::Base
	after_create :send_order_create_email
	
	def paypal_url(return_path)
		values = {
			business: "gabecorso-facilitator@aol.com",
			cmd: "_xclick",
			upload: 1,
			return: "#{Rails.application.secrets.app_host}#{return_path}",
			invoice: id,
			amount: 10,
			item_name: "orange",
			item_number: 5,
			quantity: '1',
			notify_url: "#{Rails.application.secrets.app_host}/hook"
		}
		"#{Rails.application.secrets.paypal_host}/cgi-bin/webscr?" + values.to_query
	end
	protected 
	def send_order_create_email
		OrderMailer.order_submitted_email(self).deliver
	end
end
