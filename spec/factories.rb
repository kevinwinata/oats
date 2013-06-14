FactoryGirl.define do
  factory :company do
    username "shit"
    name "Mario Orlando"
    email "maria@example.com" 
    contact "0819812492174"
    address "Pisang 21"
    password "1234567"
    password_confirmation "1234567"
  end

  factory :office do
    latitude -90
    longitude -180
    name "Blah"
    company
  end

  factory :employee do
    email "oteng@email.com"
    name "Mario"
    division "IT"
    mobile_number "2378947283"
    password "1234567"
    password_confirmation "1234567"
    office
  end
end