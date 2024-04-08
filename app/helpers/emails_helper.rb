module EmailsHelper

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
