FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "username_#{n}"
    end
    firstname "Dummy"
    lastname "Dummy"
    email "Dummy@email.com"
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :school do
    sequence :name do |n|
      "school_#{n}"
    end
  end  
end