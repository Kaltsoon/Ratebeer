FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating, :class => Rating do
    score 10
  end

  factory :rating2, :class => Rating do
    score 20
  end

  factory :beer do
    name "Kalja"
    style "Bisse"
  end

  factory :brewery do
    name "Kaljala"
    year 2014
  end
end