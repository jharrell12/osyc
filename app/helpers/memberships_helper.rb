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

end
