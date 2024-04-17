require "test_helper"

class MembershipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @membership = memberships(:one)
  end

  test "should get index" do
    get memberships_url
    assert_response :success
  end

  test "should get new" do
    get new_membership_url
    assert_response :success
  end

  test "should create membership" do
    assert_difference("Membership.count") do
      post memberships_url, params: { "membership"=>{"status"=>"Inquiry", "start_date"=>"2024-04-16", "children"=>"", "boats"=>""}, "people"=>{"0"=>{"last_name"=>"smith", "first_name"=>"", "dob"=>""}, "1"=>{"last_name"=>"", "first_name"=>"", "dob"=>""}}, "phones"=>{"0"=>{"number"=>""}, "1"=>{"number"=>""}}, "emails"=>{"0"=>{"address"=>""}, "1"=>{"address"=>""}}, "address"=>{"street"=>"", "city"=>"", "state"=>"", "zipcode"=>""} }
    end
    assert_redirected_to memberships_url
  end

  test "should show membership" do
    get membership_url(@membership)
    assert_response :success
  end

  test "should get edit" do
    get edit_membership_url(@membership)
    assert_response :success
  end

  test "should update membership" do
    patch membership_url(@membership), params: { membership: { boats: @membership.boats, children: @membership.children, end_date: @membership.end_date, slip_assignment: @membership.slip_assignment, start_date: @membership.start_date, status: @membership.status } }
    assert_redirected_to membership_url(@membership)
  end

  test "should destroy membership" do
    assert_difference("Membership.count", -1) do
      delete membership_url(@membership)
    end

    assert_redirected_to memberships_url
  end
end
