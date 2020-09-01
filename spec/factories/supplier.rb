FactoryBot.define do
  factory :supplier do
    name {Faker::Name.name}
    taxNum {Faker::Number.decimal_part(digits: 10)}
    address {Faker::Address.city}
    sup_type {true}
    user_id {FactoryBot.create(:user).id}
  end
end
