FactoryBot.define do
  factory :request_detail do
    section_name{FactoryBot.create(:section).name}
    description{Faker::Lorem.sentence(word_count: 2)}
    amount{Faker::Number.positive}
  end
end
