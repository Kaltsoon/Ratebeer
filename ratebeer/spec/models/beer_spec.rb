require 'spec_helper'

describe Beer do
  let(:style){FactoryGirl.create(:style)}
  it "is added if has name and style" do
  	beer=Beer.create(style: style, name: "karhu")
  	expect(beer).to be_valid
  end
  it "has a name" do
  	beer=Beer.create(style: style)
  	expect(beer.valid?).to be(false)
  end
  it "has a style" do
  	beer=Beer.create(name: "karhu")
  	expect(beer.valid?).to be(false)
  end
end
