module MembershipsHelper
  def membership_actions(member)
    [navbar_button_group do |s|
      s << edit_button(nil, membership_path(member))
      #s << delete_button(nil, membership_path(member), "Member #{member.id}")
      #s << button_to("Delete this membership", member, method: :delete)
    end, 1]   
  end  
end
