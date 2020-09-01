FactoryBot.define do
  factory :income do
    title {Faker::Lorem.sentence(word_count: 2)}
    content {Faker::Lorem.sentence(word_count: 5)}
    amount {Faker::Number.between(from: Settings.min_faker_amount, to: Settings.max_faker_amount)}
    currency {Faker::Currency.code}
    status {Faker::Number.between(from: Settings.min_faker_status, to: Settings.max_faker_status)}
    user_id {FactoryBot.create(:user).id}
    supplier_id {FactoryBot.create(:supplier).id}
  end
end
