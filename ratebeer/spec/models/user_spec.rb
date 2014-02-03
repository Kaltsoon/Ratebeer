require 'spec_helper'
  describe User do
    let(:user){ FactoryGirl.create(:user) }
    it "doesn't accept too short password" do
    	user=User.create(username: "Timo", password: "a")
    	expect(user.valid?).to be(false)
    end
    it "doesn't accept password without uppercase letter" do
    	user=User.create(username: "Timo", password: "timo")
    	expect(user.valid?).to be(false)
    end
    it "doesn't accept password without number" do
    	user=User.create(username: "Timo", password: "Timo")
    	expect(user.valid?).to be(false)
    end
    it "accepts valid password" do
    	user=User.create(username: "Timo", password: "Timo1")
    	expect(user.valid?).to be(true)
    end
    it "has favorite beer style" do
      user.should respond_to :favorite_style
      beer=FactoryGirl.create(:beer)
      rating=FactoryGirl.create(:rating, beer: beer, user: user)
      user.ratings.push(rating)
      user.favorite_style.should==rating.beer.style
    end
    it "has favorite brewery" do 
      user.should respond_to :favorite_brewery
      brewery=FactoryGirl.create(:brewery)
      beer=FactoryGirl.create(:beer, brewery: brewery)
      rating=FactoryGirl.create(:rating, beer: beer, user: user)
      user.ratings.push(rating)
      user.favorite_brewery.name.should==rating.beer.brewery.name
    end
end
