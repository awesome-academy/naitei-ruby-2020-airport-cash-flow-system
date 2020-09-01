require "rails_helper"

RSpec.describe Income, type: :model do
  let!(:section) {FactoryBot.create :section}
  let!(:user) {FactoryBot.create :user, section_id: section.id, role: User.roles[:accountant]}
  let!(:supplier) {FactoryBot.create :supplier}

  describe "Validations" do
    context "when all required fields given" do
      let(:income) {FactoryBot.create :income, user_id: user.id, supplier_id: supplier.id}

      it "should be true" do
        expect(income.valid?).to eq true
      end
    end

    context "when missing required fields" do
      let(:income_fail) {FactoryBot.build :income, title: nil}

      it "should be false" do
        expect(income_fail.valid?).to eq false
      end
    end
  end

  describe "Associations" do
    it "should belong to user" do
      is_expected.to belong_to(:user)
    end

    it "should belong to supplier" do
      is_expected.to belong_to(:supplier)
    end
  end

  describe "Delegates" do
    context "with delegate to user's name" do
      it "should be true" do
        is_expected.to delegate_method(:name).to(:user).with_prefix(true)
      end
    end

    context "with delegate to status's name" do
      it "should be true" do
        is_expected.to delegate_method(:name).to(:status).with_prefix(true).allow_nil
      end
    end
  end

  describe "Scopes" do
    include_examples "create example incomes"

    context "find by" do
      it "should return incomes sort by status and datetime" do
        expect(Income.by_status_then_created_at.size).to eq(3)
      end
    end
  end

  describe "Enums" do
    context "when status has pending, approved, rejected or canceled" do
      it "should be true" do
        is_expected.to define_enum_for(:status).with_values(pending: 1, approved: 2, rejected: 3, canceled: 4)
      end
    end
  end
end
