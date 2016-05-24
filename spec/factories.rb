FactoryGirl.define do
  factory :user do
    sequence :username do |n|
      "username_#{n}"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
    
  end

  factory :school do
    sequence :name do |n|
      "Colegio_#{n}"
    end
  end  
end