RSpec.shared_examples "create example users" do
  before do
    FactoryBot.create(
      :user,
      name: "Test User 0",
      email: "user1@test.com",
      role: 1,
      section_id: section.id
    )
    FactoryBot.create(
      :user,
      name: "Test User 1",
      email: "user2@test.com",
      role: 1,
      section_id: section.id
    )
    FactoryBot.create(
      :user,
      name: "Test User 2",
      email: "user3@test.com",
      role: 1,
      section_id: section.id
    )
    FactoryBot.create(
      :user,
      name: "Test Admin 1",
      email: "admin1@test.com",
      role: 1,
      section_id: section.id
    )
  end
end
