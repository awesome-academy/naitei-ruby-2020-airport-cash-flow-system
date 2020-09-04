FactoryBot.define do
  factory :request do
    user_id{FactoryBot.create(:user).id}
    title{Faker::Lorem.sentence(word_count: 2)}
    content{Faker::Lorem.sentence(word_count: 20)}
    currency{Faker::Currency.code}
    status{rand(1..5)}
    request_details_attributes {
      [FactoryBot.attributes_for(:request_detail),
       FactoryBot.attributes_for(:request_detail)]
    }
  end

  trait :reason_required do
    status{4}
    reason{Faker::Lorem.sentence(word_count: 3)}
  end
end
