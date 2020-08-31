RSpec.shared_examples "create example sections" do
  before do
    FactoryBot.create(
      :section,
      name: "Section A"
    )
    FactoryBot.create(
      :section,
      name: "Section B"
    )
    FactoryBot.create(
      :section,
      name: "Section C"
    )
    FactoryBot.create(
      :section,
      name: "Section D"
    )
    FactoryBot.create(
      :section,
      name: "Section E"
    )
  end
end
