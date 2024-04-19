module PaymentsHelper
	def payment_str(payment)
		payment.payment_str
	end  

	def payment_link(payment)
		#link_to(payment_str(payment),edit_payment_path(payment), class:  'text-decoration-none')
		#safe_join([edit_link(nil, edit_payment_path(payment)), link_to(payment_str(payment),edit_payment_path(payment), class:  'text-decoration-none')], ' '.to_nb)
		safe_join([edit_link(nil, edit_payment_path(payment)), payment_str(payment)], ' '.to_nb)
	end

	def payment_links(invoice)
		invoice.payments.collect{|payment| payment_link(payment)}
	end

	def payments_links(invoice)
		safe_join(payment_links(invoice) << add_link(svg_plus, new_payment_path(invoice_id: invoice)), '<br>'.html_safe)
	end
end
