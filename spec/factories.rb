FactoryGirl.define do
  sequence(:name)   { |s| "School_#{s}" }
  sequence(:comida) { |c| "Comida_#{c}" }
  sequence(:email)  { |e| "Dummy_#{e}@email.com" }
  sequence(:periodo){ |p|  p.days.from_now.to_date }
  

  
  factory :food do
    comida
    tipo 1
  end

  factory :school do
    name
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
    association :user, factory: :user
    association :school, factory: :school
  end  
  
  factory :child do
    nombre        "Pedrito"
    grado         1
    division      "A"
    tipo_servicio 1
    comentario    "Es un buen pibe"
    association :family, factory: :family
  end

  factory :comment do
    message     "Este es un comentario"
    association :family, factory: :family
  end  
  
  factory :movement do
    tipo        1   # Pago
    monto       500
    forma       1   # Efectivo
    descuento   0.00
    nota        "Esta es una nota de un movimiento"
    association :family, factory: :family
    association :user, factory: :user
    association :school, factory: :school
    #### Activar una vez que funcione BILL de vuelta!!!
    #association :bill, factory: :bill
  end
  
  factory :user do
    email
    firstname "Dummy"
    lastname "Dummy"
    password "secretPassword"
    password_confirmation "secretPassword"
  end

  factory :bill do
    periodo
    tipo         Bill::TIPOS_FACTURACION['Mensual']
    limite_grp_1 Child::GRADOS['1er Grado']
    valor_1      100.00
    limite_grp_2 Child::GRADOS['3er Grado']
    valor_2      200.00
    limite_grp_3 Child::GRADOS['7mo Grado']
    valor_3      300.00
    association :school, factory: :school
    association :user, factory: :user
  end

end