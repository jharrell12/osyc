module InvoicesHelper

  def invoice_actions(invoice)
    [navbar_button_group do |s|
      s << edit_button(nil, edit_invoice_path(invoice))
      s << delete_button(nil, invoice_path(invoice), "Invoice #{invoice.id}")
    end, 1]
  end

end
