module PhonesHelper
  
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

end
