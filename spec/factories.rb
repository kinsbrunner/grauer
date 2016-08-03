FactoryGirl.define do
  factory :food do
    sequence :comida do |n|
      "Comida_#{n}"
    end
    tipo 1
  end
  
  
  factory :school do
    sequence :name do |n|
      "School_#{n}"
    end
  end
  
  
  factory :family do
    apellido    "Kinsbrunner"
    contacto_1  "Alejandro"
    contacto_2  "Daniel"
    tel_cel     "15-1111-2222"
    tel_casa    "3333-4444"
    tel_alt     "5555-6666"
    email       "dummy@gmail.com"
    direccion   "Callecita 1234"
    activo      true
    user_id     1
    school_id   1
  end  
  
  
  factory :user do
    sequence :email do |n|
      "Dummy_#{n}@email.com"
    end
    firstname "Dummy"
    lastname "Dummy"
    password "secretPassword"
    password_confirmation "secretPassword"
  end


end