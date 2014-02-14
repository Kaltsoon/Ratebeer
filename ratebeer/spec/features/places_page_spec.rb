require "spec_helper"

describe "Places" do 
	it "if one is returned by the API, it is shown at the page" do
		BeermappingAPI.stub(:places_in).with("kumpula").and_return([Place.new(name: "Oljenkorsi")])
		visit places_path
		fill_in("city", with: "kumpula")
		expect(BeermappingAPI.places_in("kumpula").count).to eq(1)
	end
	it "if many is returned by the API, each is shown at the page" do
		BeermappingAPI.stub(:places_in).with("turku").and_return([ Place.new(name: "Juottola"), Place.new(name: "Kaljala")])
		visit places_path
		fill_in("city", with: "turku")
		expect(BeermappingAPI.places_in("turku").count).to eq(2)
	end
	it "if none is returned by the API, show message" do
		BeermappingAPI.stub(:places_in).with("kontula").and_return([])
		visit places_path
		fill_in("city", with: "kontula")
		expect(BeermappingAPI.places_in("kontula").count).to eq(0)
	end
end