require "rails_helper"
require "spec_helper"
include RSpecSessionHelper

RSpec.describe Accountant::IncomesController, type: :controller do
  let!(:income_1) { FactoryBot.create(:income) }
  let!(:income_2) { FactoryBot.create(:income) }
  let!(:income_3) { FactoryBot.create(:income) }
  let(:accountant) { FactoryBot.create(:user, role: User.roles[:accountant])}
  let(:invalid_income) {
    FactoryBot.build(:income,
      title: "",
    ).as_json
  }

  before(:each) do
    login_as_accountant
  end

  describe "GET incomes#index" do
    it "should render a list of incomes" do
      get :index
      expect(assigns(:incomes).size).to eq Income.by_status_then_created_at.size
    end

    it "should render :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST incomes#new" do
    it "should render :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST incomes#create" do
    context "with valid attributes" do
      it "should create new income object" do
        get :new
        expect(assigns(:income)).to be_a_new(Income)
      end

      it "should create a new income" do
        @new_income = FactoryBot.create(:income)
        expect {
          post :create, params: {income: FactoryBot.attributes_for(:income)}
        }.to change(Income, :count).by(1)
      end

      it "should redirect to the new income" do
        post :create, params: {income: FactoryBot.attributes_for(:income)}
        expect(response).to redirect_to accountant_incomes_url
      end
    end

    context "with invalid attribute(s)" do
      it "should not create a new income" do
        expect {
          post :create, params: { income: invalid_income }
        }.to_not change(Income, :count)
      end

      it "should re-render :new view" do
        post :create, params: { income: invalid_income }
        expect(response).to render_template :new
      end
    end
  end
end
