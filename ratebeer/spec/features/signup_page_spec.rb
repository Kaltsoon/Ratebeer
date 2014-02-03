require "spec_helper"

describe "who has signed up" do
	it "is redirected back to sign in form if wrong password given" do
		visit signin_path
		fill_in("username", with: "Pekka")
		fill_in("password", with: "wrong")
		click_button("Log in")
		expect(current_path).to eq(signin_path)
		expect(page).to have_content "username and password do not match"
	end
end