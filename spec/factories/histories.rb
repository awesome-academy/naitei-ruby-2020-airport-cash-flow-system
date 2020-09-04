FactoryBot.define do
  factory :history do
    request_id{FactoryBot.create(:request).id}
    paid_time{Time.now}
  end
end
