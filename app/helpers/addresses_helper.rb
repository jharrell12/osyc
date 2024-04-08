module AddressesHelper
  
  def address_actions(addr)
    [navbar_button_group do |s|
      s << edit_link(nil, edit_address_path(addr))
      s << '  '.to_nb
      s << turbo_delete_link(nil, address_path(addr))
    end, 1]
  end

  def address_caption(membership)
    data_table_caption('Addresses', button_group_div(add_button((svg_house_plus), new_address_path(membership_id: membership.id))) )
  end

  def address_header
    field_label_row(%w(action type for street city state zipcode).map(&:titlecase))
  end

  def address_row(addr)
    flds = [addr.label, addr.person&.first_name, addr.street, addr.city, addr.state, addr.zipcode]
    if !addr.current?
      flds = flds.collect{|fld| content_tag(:del, fld, class: 'fw-light fst-italic')}
    end
    flds.prepend(address_actions(addr))
  end

  def addresses_table(membership)
    data_table(address_caption(membership), address_header) do |s|
      membership.addresses.sorted.each do |addr|
        s << data_item_row(address_row(addr))
      end
    end  
  end

end
