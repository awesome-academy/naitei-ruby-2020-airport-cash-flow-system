require "rails_helper"

RSpec.describe Supplier, type: :model do
  let!(:section) {FactoryBot.create :section}
  let(:user) {FactoryBot.create :user, section_id: section.id, role: User.roles[:accountant]}
  let!(:supplier) {FactoryBot.create :supplier, user_id: user.id}
  let!(:supplier_fail) {FactoryBot.build :supplier, name: nil}

  describe "Validations" do
    context "when all required fields given" do
      it "should be true" do
        expect(supplier.valid?).to eq true
      end
    end

    context "when missing required fields" do
      it "should be false" do
        expect(supplier_fail.valid?).to eq false
      end
    end
  end

  describe "Associations" do
    it "should belong to user" do
      is_expected.to belong_to(:user)
    end

    it "should has many incomes" do
      is_expected.to have_many(:incomes).dependent(:destroy)
    end
  end

  describe "Scopes" do
    include_examples "create example suppliers"

    context "belongs to" do
      it "should return supplier of that person" do
        expect(Supplier.own_supplier(user.id).size).to eq(4)
      end
    end
  end

  describe "Delegates" do
    context "with delegate to user's name" do
      it "should be true" do
        is_expected.to delegate_method(:name).to(:user).with_prefix(true)
      end
    end
  end
end
