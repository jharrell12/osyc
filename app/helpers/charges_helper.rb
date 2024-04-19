module ChargesHelper

	def charge_str(charge)
		charge.charge_str
	end  

	def charge_link(charge)
		#link_to(charge_str(charge),edit_charge_path(charge), class:  'text-decoration-none')
		#safe_join([edit_link(nil, edit_charge_path(charge)), link_to(charge_str(charge),edit_charge_path(charge), class:  'text-decoration-none')], ' '.to_nb)
		safe_join([edit_link(nil, edit_charge_path(charge)), charge_str(charge)], ' '.to_nb)
	end

	def charge_links(invoice)
		invoice.charges.collect{|charge| charge_link(charge)}
	end

	def charges_links(invoice)
		safe_join(charge_links(invoice) << add_link(svg_plus, new_charge_path(invoice_id: invoice)), '<br>'.html_safe)
	end

end
