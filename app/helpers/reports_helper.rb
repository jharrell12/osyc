module ReportsHelper
  def address_two_line(membership)
    safe_join(membership.addresses.select{|a| a.current?}.collect{|a| [a.street, "#{a.city}, #{a.state} #{a.zipcode}"]}, '<br>'.html_safe)
  end
  
end
