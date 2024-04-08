module PeopleHelper

  def person_actions(person)
    [navbar_button_group do |s|
      s << edit_link(nil, edit_person_path(person))
      s << '  '.to_nb
      s << turbo_delete_link(nil, person_path(person), "Person #{person.id}")
    end, 1]
  end

end
