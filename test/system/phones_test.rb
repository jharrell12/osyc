require "application_system_test_case"

class PhonesTest < ApplicationSystemTestCase
  setup do
    @phone = phones(:one)
  end

  test "visiting the index" do
    visit phones_url
    assert_selector "h1", text: "Phones"
  end

  test "should create phone" do
    visit phones_url
    click_on "New phone"

    fill_in "End date", with: @phone.end_date
    fill_in "Label", with: @phone.label
    fill_in "Number", with: @phone.number
    fill_in "Person", with: @phone.person_id
    fill_in "Start date", with: @phone.start_date
    click_on "Create Phone"

    assert_text "Phone was successfully created"
    click_on "Back"
  end

  test "should update Phone" do
    visit phone_url(@phone)
    click_on "Edit this phone", match: :first

    fill_in "End date", with: @phone.end_date
    fill_in "Label", with: @phone.label
    fill_in "Number", with: @phone.number
    fill_in "Person", with: @phone.person_id
    fill_in "Start date", with: @phone.start_date
    click_on "Update Phone"

    assert_text "Phone was successfully updated"
    click_on "Back"
  end

  test "should destroy Phone" do
    visit phone_url(@phone)
    click_on "Destroy this phone", match: :first

    assert_text "Phone was successfully destroyed"
  end
end
