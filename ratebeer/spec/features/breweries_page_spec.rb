require 'spec_helper'

describe "Breweries page" do
	it "should not have any before been created" do
		visit breweries_path
		expect(page).to have_content "Listing breweries"
		expect(page).to have_content "number of breweries 0"
	end
	it "should have 3 breweries" do
		breweries=["Koff", "Karjala", "Schelenkerla"]
		breweries.each do |b|
			FactoryGirl.create(:brewery, name: b)
		end
		visit breweries_path
		expect(page).to have_content "number of breweries #{breweries.count}"
		breweries.each do |b|
			expect(page).to have_content b
		end
	end
	it "should have links to page of each brewery" do
		breweries=["Koff", "Karjala", "Schelenkerla"]
		year=1896
		breweries.each do |b|
			FactoryGirl.create(:brewery, name: b, year: year+=1)
		end
		visit breweries_path
		click_link "Koff"
		expect(page).to have_content "Koff"
		expect(page).to have_content "Established year 1897"
	end
end