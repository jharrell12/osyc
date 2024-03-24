require "application_system_test_case"

class EmailsTest < ApplicationSystemTestCase
  setup do
    @email = emails(:one)
  end

  test "visiting the index" do
    visit emails_url
    assert_selector "h1", text: "Emails"
  end

  test "should create email" do
    visit emails_url
    click_on "New email"

    fill_in "Address", with: @email.address
    fill_in "End date", with: @email.end_date
    fill_in "Label", with: @email.label
    fill_in "Person", with: @email.person_id
    fill_in "Start date", with: @email.start_date
    click_on "Create Email"

    assert_text "Email was successfully created"
    click_on "Back"
  end

  test "should update Email" do
    visit email_url(@email)
    click_on "Edit this email", match: :first

    fill_in "Address", with: @email.address
    fill_in "End date", with: @email.end_date
    fill_in "Label", with: @email.label
    fill_in "Person", with: @email.person_id
    fill_in "Start date", with: @email.start_date
    click_on "Update Email"

    assert_text "Email was successfully updated"
    click_on "Back"
  end

  test "should destroy Email" do
    visit email_url(@email)
    click_on "Destroy this email", match: :first

    assert_text "Email was successfully destroyed"
  end
end
