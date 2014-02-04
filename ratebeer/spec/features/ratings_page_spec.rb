require "spec_helper"

describe "Ratings page" do
	let(:style){ FactoryGirl.create(:style) }
	it "has list of all ratings" do
		beer=FactoryGirl.create(:beer, style: style, name: "Kalja")
		u1=FactoryGirl.create(:user)
		login("Pekka","Foobar1")
		r1=FactoryGirl.create(:rating, score: 20, beer: beer, user: u1)
		visit ratings_path
		expect(page).to have_content("Kalja 20")
		expect(page).to have_content("number of ratings 1")
	end
	def login(username, password)
		visit signin_path
		fill_in("username", with: username)
		fill_in("password", with: password)
		click_button("Log in")
	end
end