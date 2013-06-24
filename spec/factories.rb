FactoryGirl.define do
  factory :company do
    username "Shit"
    name "Mario Orlando"
    email "maria@example.com" 
    contact "0819812492174"
    address "Pisang 21"
    password "1234567"
    password_confirmation "1234567"
  end

  factory :office do
    latitude -89
    latitude_min -90
    latitude_max -88.9
    longitude -179
    longitude_min -180
    longitude_max -178.9
    name "Blah"
    range 100
    company
  end

  factory :employee do
    email "ong@email.com"
    name "Mario"
    division "IT"
    mobile_number "2378947283"
    password "1234567"
    password_confirmation "1234567"
    office
  end

  factory :wrong_company do
    username "Otsaeng"
    name "Mariaso Orlando"
    email "marasdio@example.com" 
    contact "0819812492174"
    address "Pisang 21"
    password "1234567"
    password_confirmation "1234567"
  end

  factory :wrong_office do
    latitude -90
    longitude -180
    name "Blah"
    wrong_company
  end

  factory :wrong_employee do
    email "oeng@email.com"
    name "Marasdio"
    division "saIT"
    mobile_number "08247283"
    password "1234567"
    password_confirmation "1234567"
    wrong_office
  end
end