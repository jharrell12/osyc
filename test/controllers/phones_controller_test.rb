require "test_helper"

class PhonesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)
    @person = people(:one)    
    @membership.people << @person
    @phone = phones(:one)
    @person.phones << @phone    
  end

  test "should get index" do
    get phones_url(person_id: @person)
    assert_response :success
  end

  test "should get new" do
    get new_phone_url(person_id: @person)
    assert_response :success
  end

  test "should create phone" do
    assert_difference("Phone.count") do
      post phones_url, params: { person_id: @person.id, phone: { end_date: @phone.end_date, label: @phone.label, number: @phone.number, person_id: @phone.person_id, start_date: @phone.start_date } }
    end

    assert_redirected_to membership_url(id: @membership.id)
  end

  test "should show phone" do
    get phone_url(@phone)
    assert_response :success
  end

  test "should get edit" do
    get edit_phone_url(@phone)
    assert_response :success
  end

  test "should update phone" do
    patch phone_url(@phone), params: { phone: { end_date: @phone.end_date, label: @phone.label, number: @phone.number, person_id: @phone.person_id, start_date: @phone.start_date } }
    assert_redirected_to membership_url(id: @membership.id)
  end

  test "should destroy phone" do
    assert_difference("Phone.current.count", -1) do
      delete phone_url(@phone)
    end

    assert_redirected_to membership_url(id: @membership.id)
  end
end
