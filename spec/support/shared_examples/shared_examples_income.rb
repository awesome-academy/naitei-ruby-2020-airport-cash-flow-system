RSpec.shared_examples "create example incomes" do
  before do
    FactoryBot.create(
      :income,
      title: "Income 1"
    )
    FactoryBot.create(
      :income,
      title: "Income 2"
    )
    FactoryBot.create(
      :income,
      title: "Income 3"
    )
  end
end
