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
      s << turbo_delete_button(nil, membership_path(member), "Member #{member.id}")
    end, 1]
  end

  def back_to_member_list_button
    link_to('Back to Members List', memberships_path, class: 'btn btn-outline-danger mx-1')
  end

  def back_to_member_button(membership)
    link_to('Back to Member', membership_path(membership), class: 'btn btn-outline-danger mx-1')
  end

  def deactivate_reactivate_button_group(rec)
    if !rec.new_record?
      if rec.end_date.present?
        navbar_button_group do |s|      
          s << button_to('Reactivate', rec, {class: 'btn py-0 btn-outline-success mx-1', method: :delete, params: {operation: :reactivate}})
          s << delete_button('Delete', rec, "this address permanently", params: {operation: :destroy})
        end
      else
        delete_button('Deactivate', rec, false, params: {operation: :deactivate})
      end
    end    
  end
end
