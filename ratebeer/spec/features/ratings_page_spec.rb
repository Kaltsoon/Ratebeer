require "spec_helper"

describe "Ratings page" do
	it "has list of all ratings" do
		beer=FactoryGirl.create(:beer, name: "Kalja")
		u1=FactoryGirl.create(:user)
		login("Pekka","Foobar1")
		r1=FactoryGirl.create(:rating, score: 20, beer: beer, user: u1)
		visit ratings_path
		expect(page).to have_content("Kalja 20")
	end
	def login(username, password)
		visit signin_path
		fill_in("username", with: username)
		fill_in("password", with: password)
		click_button("Log in")
	end
end