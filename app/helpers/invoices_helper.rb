module InvoicesHelper

  def invoice_actions(invoice)
    [navbar_button_group do |s|
      s << edit_link(nil, edit_invoice_path(invoice))
      s << '  '.to_nb
      s << turbo_delete_link(nil, invoice_path(invoice), "Invoice #{invoice.id}")
    end, 1]
  end

  def invoices_caption(membership)
    data_table_caption('Invoices', button_group_div(add_button((svg_show), invoices_path(membership_id: @membership.id))) )
  end

  def invoices_header
    field_label_row(%w(action status posted_date due_date balace_due).map(&:titlecase))
  end

  def invoice_row(invoice)
    data_item_row([invoice_actions(invoice), invoice.status, invoice.posted_date, invoice.due_date, invoice.balance_due])
  end

  def invoices_table(membership)
    data_table(invoices_caption(membership), invoices_header) do |s|
      membership.invoices.each do |invoice|
        s << invoice_row(invoice)
      end
    end
  end

end
