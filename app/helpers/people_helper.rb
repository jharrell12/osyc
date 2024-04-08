module PeopleHelper

  def person_actions(person)
    [navbar_button_group do |s|
      s << edit_link(nil, edit_person_path(person))
      s << '  '.to_nb
      s << turbo_delete_link(nil, person_path(person), "Person #{person.id}")
    end, 1]
  end

  def people_caption(membership)
    data_table_caption('People and Contacts', button_group_div(add_button((svg_person_plus), new_person_path(membership_id: @membership.id))) )
  end

  def people_header
    field_label_row(%w(action first_name last_name  dob phone email).map(&:titlecase))
  end

  def person_row(person)
    data_item_row([person_actions(person), person.first_name, person.last_name, person.dob, phones_links(person), emails_links(person)])
  end

  def people_table(membership)
    data_table(people_caption(membership), people_header) do |s|
      membership.people.each do |person|
        s << person_row(person)
      end
    end    
  end

end
