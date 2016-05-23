FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "username_#{n}"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
    
  end
end