require "rails_helper"

RSpec.describe Request, type: :model do
  describe "validations" do
    context "when all required field are given" do
      let(:request){FactoryBot.build :request, :reason_required}
      it "should be true" do
        expect(request.valid?).to eq true
      end
    end

    context "when required field is missing" do
      let(:invalid_request){FactoryBot.build :request, user_id: nil}
      it "should be false" do
        expect(invalid_request.valid?).to eq false
      end
    end

    context "when reason is missing when status is 'rejected'" do
      let(:invalid_request){FactoryBot.build(:request, :reason_required, reason: nil)}
      it "should be false" do
        expect(invalid_request.valid?).to eq false
      end
    end

    context "when request_details is missing" do
      let(:invalid_request){FactoryBot.build :request, request_details_attributes: []}
      it "should be false" do
        expect(invalid_request.valid?).to eq false
      end
    end
  end


  describe "associations" do
    it "should belong to user" do
      is_expected.to belong_to :user
    end

    it "should have many histories" do
      is_expected.to have_many(:histories).dependent :destroy
    end

    it "should have many request_detail" do
      is_expected.to have_many(:request_details).dependent :destroy
    end
  end

  describe "delegations" do
    it "should delegate to user with method #name" do
      should delegate_method(:name).to(:user).with_prefix
    end
  end

  describe "scopes" do
    describe "#own_request" do
      let(:user){FactoryBot.create :user}
      let(:request){FactoryBot.create :request, :reason_required, user_id: user.id}
      it "should return request of user with user_id" do
        expect(Request.own_request(user.id)).to eq [request]
      end
    end

    describe "#find_requests_by_section" do
      let(:section){FactoryBot.create :section}
      let(:user){FactoryBot.create :user, section_id: section.id}
      let(:request){FactoryBot.create :request, :reason_required, user_id: user.id}
      it "should return request belongs to section with section_id" do
        expect(Request.find_requests_by_section(section.id)).to eq [request]
      end
    end
  end
end
