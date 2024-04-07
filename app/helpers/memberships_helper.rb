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
    #link_to(phone_str(phone),edit_phone_path(phone), class:  'text-decoration-none')
    #safe_join([edit_link(nil, edit_phone_path(phone)), link_to(phone_str(phone),edit_phone_path(phone), class:  'text-decoration-none')], ' '.to_nb)
    safe_join([edit_link(nil, edit_phone_path(phone)), phone_str(phone)], ' '.to_nb)
  end

  def phone_links(person)
    person.phones.collect{|phone| phone_link(phone)}
  end

  def phones_links(person)
    safe_join(phone_links(person) << add_link(svg_phone_plus, new_phone_path(person_id: person)), '<br>'.html_safe)
  end


  def email_str(email)
    email.current? ? email.address : content_tag(:del, email.address, class: 'fw-light fst-italic')
  end

  def email_link(email)
    #link_to(email_str(email), edit_email_path(email))
    #safe_join([link_to(svg_pencil, edit_email_path(email), class: 'text-success'), link_to(email_str(email),edit_email_path(email))], ' '.to_nb)
    safe_join([edit_link(nil, edit_email_path(email)), email_str(email)], ' '.to_nb)
  end

  def collect_email_links(person)
    person.emails.collect{|email| email_link(email) }
  end

  def emails_links(person)
    safe_join(collect_email_links(person) << add_link(svg_email_plus, new_email_path(person_id: person)), '<br>'.html_safe)
    
  end  

end
