module InvoicesHelper

  def invoice_actions(invoice)
    [navbar_button_group do |s|
      s << edit_link(nil, edit_invoice_path(invoice))
      s << '  '.to_nb
      invoice.status == "Draft" ? s << turbo_delete_link(nil, invoice_path(invoice), "Invoice #{invoice.id}") : nil
    end, 1]
  end

  def invoices_caption(membership)
    data_table_caption('Invoices', button_group_div(add_button((svg_show), invoices_path(membership_id: @membership.id))) )
  end

  def invoices_header
    field_label_row(%w(status posted_date due_date balace_due).map(&:titlecase))
  end

  # TODO: make posted date display just date, not time
  def invoice_row(invoice)
    data_item_row([invoice.status, invoice.posted_date&.strftime('%F'), invoice.due_date, invoice.balance_due])
  end

  def invoices_table(membership)
    data_table(invoices_caption(membership), invoices_header) do |s|
      membership.invoices.each do |invoice|
        s << invoice_row(invoice)
      end
    end
  end

end
