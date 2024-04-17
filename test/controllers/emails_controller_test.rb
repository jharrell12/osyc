require "test_helper"

class EmailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)
    @person = people(:one)    
    @membership.people << @person
    @email = emails(:one)
    @person.emails << @email
  end

  test "should get index" do
    get emails_url(person_id: @person)
    assert_response :success
  end

  test "should get new" do
    get new_email_url(person_id: @person)
    assert_response :success
  end

  test "should create email" do
    assert_difference("Email.count") do
      post emails_url, params: { person_id: @person.id, email: { address: @email.address, end_date: @email.end_date, label: @email.label, person_id: @email.person_id, start_date: @email.start_date } }
    end

    assert_redirected_to membership_url(id: @membership.id)
  end

  test "should show email" do
    get email_url(@email)
    assert_response :success
  end

  test "should get edit" do
    get edit_email_url(@email)
    assert_response :success
  end

  test "should update email" do
    patch email_url(@email), params: { email: { address: @email.address, end_date: @email.end_date, label: @email.label, person_id: @email.person_id, start_date: @email.start_date } }
    assert_redirected_to membership_url(id: @membership.id)
  end

  test "should destroy email" do
    assert_difference("Email.current.count", -1) do
      delete email_url(@email)
    end

    assert_redirected_to membership_url(id: @membership.id)
  end
end
