require 'rails_helper'

describe "Able to click on a link that leads to home", type: :feature do
  it "redirects to home" do
    visit root_path
    click_link "Home"
    expect(current_path).to eq(root_path)
  end
end


describe "user logins with email", type: :feature do
  before :each do
    @user = FactoryGirl.create(:user)
  end

  it "redirects to home" do
    visit root_path
    click_link "Login with email"

    expect(current_path).to eq(new_session_path)
    fill_in "session[email]", with: "foobar@gmail.com"
    fill_in "session[password]", with: "foobar1234"
    click_button "Sign in"
    expect(current_path).to eq(root_path)
    expect(page.body).to have_content("Looks like you decided to sign in with email, so no twitter functions for you")

  end
end