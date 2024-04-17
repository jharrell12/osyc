require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)
    @person = people(:one)
    @membership.people << @person
  end

  test "should get index" do
    get people_url(membership_id: @membership)
    assert_response :success
  end

  test "should get new" do
    get new_person_url(membership_id: @membership)
    assert_response :success
  end

  test "should create person" do
    assert_difference("Person.count") do
      post people_url, params: { membership_id: @membership.id, person: { birth_year: @person.birth_year, dob: @person.dob, first_name: @person.first_name, last_name: @person.last_name, membership_id: @person.membership_id } }
    end

    assert_redirected_to membership_url(@person.membership_id)
  end

  test "should show person" do
    get person_url(@person)
    assert_response :success
  end

  test "should get edit" do
    get edit_person_url(@person)
    assert_response :success
  end

  test "should update person" do
    patch person_url(@person), params: { person: { birth_year: @person.birth_year, dob: @person.dob, first_name: @person.first_name, last_name: @person.last_name, membership_id: @person.membership_id } }
    assert_redirected_to membership_url(@person.membership_id)
  end

  test "should destroy person" do
    assert_difference("Person.count", -1) do
      delete person_url(@person)
    end

    assert_redirected_to membership_url(@person.membership_id)
  end
end
