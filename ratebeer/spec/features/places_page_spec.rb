require "spec_helper"

describe "Places" do 
	it "if one is returned by the API, it is shown at the page" do
		BeermappingAPI.stub(:places_in).with("kumpula").and_return([ Place.new(name: "Oljenkorsi")])
		visit places_path
		fill_in("city", with: "kumpula")
		click_button("Search")
		expect(page).to have_content("Oljenkorsi")
	end
	it "if many is returned by the API, each is shown at the page" do
		BeermappingAPI.stub(:places_in).with("turku").and_return([ Place.new(name: "Juottola"), Place.new(name: "Kaljala")])
		visit places_path
		fill_in("city", with: "turku")
		click_button("Search")
		expect(page).to have_content("Juottola")
		expect(page).to have_content("Kaljala")
	end
	it "if none is returned by the API, show message" do
		BeermappingAPI.stub(:places_in).with("kontula").and_return([])
		visit places_path
		fill_in("city", with: "kontula")
		click_button("Search")
		expect(page).to have_content "No places in kontula"
	end
end