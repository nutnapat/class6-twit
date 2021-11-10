require "application_system_test_case"
class MainTest < ApplicationSystemTestCase
  
  test "login_fail" do
    visit main_path
    fill_in "Email", with: 'aaaaaa'
    fill_in "Password", with: 'aaaaa'
    click_on "Login"
    assert_selector "h1", text: "wrong password or email"
  end

  test "login_success" do
    visit main_path
    fill_in "Email", with: "x"
    fill_in "Password", with: "111111"
    click_on "Login"
    assert_selector "p", text: "login successfully"
  end

  test "like" do
    visit "/main"
    fill_in "Email", with: "x"
    fill_in "Password", with: "111111"
    click_on "Login"
  # b like a
    click_button 'Like'
    visit "/profile/a"
    click_button '1 Likes'
    assert_text "b"
  end  
end