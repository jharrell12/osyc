module MembershipsHelper
  def membership_actions(member)
    [navbar_button_group do |s|
      s << show_button(nil, membership_path(member))
      #s << delete_button(nil, membership_path(member), "Member #{member.id}")
      #s << button_to("Delete this membership", member, method: :delete)
    end, 1]
  end

  def member_actions(member)
    [navbar_button_group do |s|
      s << edit_button(nil, edit_membership_path(member))
      s << delete_button(nil, membership_path(member), "Member #{member.id}")
    end, 1]
  end

  def back_to_member_list_button
    link_to('Back to Member List', memberships_path, class: 'btn btn-outline-danger mx-1')
  end

  def back_to_member_button(membership)
    link_to('Back to Member', membership_path(membership), class: 'btn btn-outline-danger mx-1')
  end


  def phone_str(phone)
    phone.current? ? phone.phone_str : content_tag(:del, phone.phone_str, class: 'fw-light fst-italic')
  end  

  def phone_link(phone)
    #safe_join([link_to(svg_pencil, edit_phone_path(phone), class: 'text-success'), link_to(phone_str(phone),edit_phone_path(phone))], ' '.to_nb)
    link_to(phone_str(phone),edit_phone_path(phone), class:  'text-decoration-none')
  end

  def phone_links(person)
    person.phones.collect{|phone| phone_link(phone)}
  end

  def phones_links(person)
    safe_join(phone_links(person) << link_to(svg_phone_plus, new_phone_path(person_id: person), class: 'text-success'), '<br>'.html_safe)
  end


  def email_link(email)
    safe_join([
      svg_pencil, 
      svg_x, 
      link_to(email.address, edit_email_path(email))
    ], '  '.to_nb)
  end

  def collect_email_links(person)
    person.emails.collect{|email| email_link(email) }
  end

  def emails_links(person)
    safe_join(collect_email_links(person) << link_to(svg_email_plus, new_email_path(person_id: person), class: 'text-success'), '<br>'.html_safe)
    
  end  

end
