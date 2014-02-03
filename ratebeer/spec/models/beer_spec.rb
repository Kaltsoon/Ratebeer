require 'spec_helper'

describe Beer do
  it "has a name" do
  	beer=Beer.create(style: "lager")
  	expect(beer.valid?).to be(false)
  end
  it "has a style" do
  	beer=Beer.create(name: "karhu")
  	expect(beer.valid?).to be(false)
  end
end
