require "test_helper"

class AddressesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)
    @person = people(:one)
    @membership.people << @person
    @address = addresses(:one)
    @person.addresses << @address
  end

  test "should get index" do
    get addresses_url(membership_id: @membership)
    assert_response :success
  end

  test "should get new" do
    get new_address_url(membership_id: @membership)
    assert_response :success
  end

  test "should create address" do
    assert_difference("Address.count") do
      post addresses_url, params: { membership_id: @membership.id, address: { city: @address.city, end_date: @address.end_date, label: @address.label, person_id: @address.person_id, start_date: @address.start_date, state: @address.state, street: @address.street, zipcode: @address.zipcode } }
    end

    assert_redirected_to membership_url(id: @membership.id)
  end

  test "should show address" do
    get address_url(@address)
    assert_response :success
  end

  test "should get edit" do
    get edit_address_url(@address)
    assert_response :success
  end

  test "should update address" do
    patch address_url(@address), params: { address: { city: @address.city, end_date: @address.end_date, label: @address.label, person_id: @address.person_id, start_date: @address.start_date, state: @address.state, street: @address.street, zipcode: @address.zipcode } }
    assert_redirected_to membership_url(id: @membership.id)
  end

  test "should destroy address" do
    assert_difference("Address.current.count", -1) do
      delete address_url(@address)
    end

    assert_redirected_to membership_url(id: @membership.id)
  end
end
