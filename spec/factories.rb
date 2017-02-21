FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :rating do
    score 10
    beer
    user
  end

  factory :rating2, class: Rating do
    score 20
    beer
    user username: "Olli"
  end

  factory :brewery do
    name "Bruuweri"
    year 1998
    active true
  end

  factory :beer do
    name "Öl"
    brewery
    style
  end

  factory :style do
    name "Pohjasakka"
    description "Pahan makuista velliä tynnyrin pohjalta."
  end
end
