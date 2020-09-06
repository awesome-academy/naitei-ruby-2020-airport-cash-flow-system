require "rails_helper"

RSpec.describe User, type: :model do
  let(:user) {FactoryBot.create :user}
  let!(:user_fail) {FactoryBot.build :user, name: nil}

  describe "Validations" do
    context "when all required fields given" do
      it "should be true" do
        expect(user.valid?).to eq true
      end
    end

    context "when missing required fields" do
      it "should be false" do
        expect(user_fail.valid?).to eq false
      end
    end
  end

  describe "Associations" do
    it "should has many requests" do
      is_expected.to have_many(:requests).dependent(:destroy)
    end

    it "should has many incomes" do
      is_expected.to have_many(:incomes).dependent(:destroy)
    end

    it "should has many notifications" do
      is_expected.to have_many(:notifications).dependent(:destroy)
    end

    it "should has many suppliers" do
      is_expected.to have_many(:suppliers).dependent(:destroy)
    end
  end

  describe "Enums" do
    context "when role has admin, accountant, manager, user and accountmanager" do
      it "should be true" do
        is_expected.to define_enum_for(:role).with_values(admin: 1, accountant: 2, manager: 3, user: 4, accountmanager: 5)
      end
    end
  end
end
