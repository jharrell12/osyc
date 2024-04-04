module PeopleHelper

  def person_actions(person)
    [navbar_button_group do |s|
      s << edit_button(nil, edit_person_path(person))
      s << delete_button(nil, person_path(person), "Person #{person.id}")
    end, 1]
  end

end
