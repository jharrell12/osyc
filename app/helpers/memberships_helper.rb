module MembershipsHelper
  def back_to_member_list_button
    link_to('Back to Members List', memberships_path, class: 'btn btn-outline-danger mx-1')
  end

  def back_to_member_button(membership)
    link_to('Back to Member', membership_path(membership), class: 'btn btn-outline-danger mx-1')
  end

  def membership_people_options_for_select(membership)
    membership.people.collect{|person| [person.full_name, person.id]}
  end

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
      s << turbo_delete_button(nil, membership_path(member), "Member #{member.id}")
    end, 1]
  end


  def member_info_table(membership)
    #caption = data_table_caption('Info', member_actions(membership).first)
    caption = data_table_caption('Info', nil)
    data_table(caption, nil) do |s|
      s << labeled_data_row('Status', membership.status.titleize)
      s << labeled_data_row('as of', membership.start_date)
      s << labeled_data_row('Boats', membership.boats)
      s << labeled_data_row('Slip', membership.slip_assignment)
      s << labeled_data_row('Children', membership.children)
      s << labeled_data_row('End Date', membership.end_date)

      s << labeled_data_row('', member_actions(membership))
    end    
  end
end
