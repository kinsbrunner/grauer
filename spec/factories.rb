FactoryGirl.define do
  factory :user do
    sequence :email do |n|
      "Dummy_#{n}@email.com"
    end
    firstname "Dummy"
    lastname "Dummy"
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :food do
    sequence :comida do |n|
      "Comida_#{n}"
    end
    tipo 1
  end
end