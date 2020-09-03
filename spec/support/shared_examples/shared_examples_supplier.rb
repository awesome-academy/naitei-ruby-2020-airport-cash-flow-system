RSpec.shared_examples "create example suppliers" do
  before do
    FactoryBot.create(
      :supplier,
      name: "NTTPC",
      user_id: user.id
    )
    FactoryBot.create(
      :supplier,
      name: "Sun Asterisk",
      user_id: user.id
    )
    FactoryBot.create(
      :supplier,
      name: "HEDSPI",
      user_id: user.id
    )
  end
end
