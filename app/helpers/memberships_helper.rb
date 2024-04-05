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

  def phones_links(person)
    safe_join([safe_join(person.phones.collect{|phone| link_to(phone.phone_str, edit_phone_path(phone))}, '<br>'.html_safe),
     link_to(svg_plus, new_phone_path(person_id: person))].compact, '  '.to_nb)
  end

  def emails_links(person)
    safe_join([safe_join(person.emails.collect{|email| link_to(email.address, edit_email_path(email))}, '<br>'.html_safe),
      link_to(svg_plus, new_email_path(person_id: person))].compact, '  '.to_nb)
  end  

end
