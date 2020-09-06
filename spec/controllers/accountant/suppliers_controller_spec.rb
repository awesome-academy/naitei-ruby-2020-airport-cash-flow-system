require "rails_helper"
require "spec_helper"
include RSpecSessionHelper

RSpec.describe Accountant::SuppliersController, type: :controller do
  let(:accountant) {FactoryBot.create :user, role: User.roles[:accountant]}
  let!(:supplier_1) {FactoryBot.create :supplier, user_id: accountant.id}
  let!(:supplier_2) {FactoryBot.create :supplier, user_id: accountant.id}
  let!(:supplier_3) {FactoryBot.create :supplier, user_id: accountant.id}
  let(:invalid_supplier) {
    FactoryBot.build(:supplier,
      name: "",
    ).as_json
  }

  before(:each) do
    login_as_accountant
  end

  describe "GET suppliers#index" do
    it "should render a list of suppliers" do
      get :index
      expect(assigns(:suppliers).size).to eq Supplier.all.size
    end

    it "should render :index view" do
      get :index
      expect(response).to render_template :index
    end
  end

  describe "POST suppliers#new" do
    it "should render :new view" do
      get :new
      expect(response).to render_template :new
    end
  end

  describe "POST suppliers#create" do
    context "with valid attributes" do
      it "should create new supplier object" do
        get :new
        expect(assigns(:supplier)).to be_a_new(Supplier)
      end

      it "should create a new supplier" do
        @new_supplier = FactoryBot.create(:supplier, user_id: accountant.id)
        expect {
          post :create, params: {supplier: FactoryBot.attributes_for(:supplier, sup_type: "personal")}
        }.to change(Supplier, :count).by(1)
      end

      it "should redirect to the new supplier" do
        post :create, params: {supplier: FactoryBot.attributes_for(:supplier, sup_type: "personal")}
        expect(response).to redirect_to accountant_suppliers_url
      end
    end

    context "with invalid attribute(s)" do
      it "should not create a new supplier" do
        expect {
          post :create, params: { supplier: invalid_supplier }
        }.to_not change(Supplier, :count)
      end

      it "should re-render :new view" do
        post :create, params: { supplier: invalid_supplier }
        expect(response).to render_template :new
      end
    end
  end

  describe "GET #edit" do
    context "with valid id" do
      it "should render view edit" do
        @accountant_test = FactoryBot.create :user, role: User.roles[:accountant]
        @supplier_to_update = FactoryBot.create :supplier, user_id: @accountant_test.id
        sign_in @accountant_test
        get :edit, params: {id: @supplier_to_update.id}
        expect(response).to render_template :edit
      end
    end
  end
  
  describe "PUT suppliers#update/:id" do
    before :each do
      @accountant_test = FactoryBot.create :user, role: User.roles[:accountant]
      @supplier_to_update = FactoryBot.create :supplier, user_id: @accountant_test.id
      sign_in @accountant_test
    end

    context "with valid attributes" do
      it "should return a supplier" do
        put :update, params: {
            id: @supplier_to_update.id,
            supplier: FactoryBot.attributes_for(:supplier, sup_type: "personal")
        }
        expect(assigns(:supplier)).to eq @supplier_to_update
      end
      
      it "should update supplier's attributes" do
        patch :update, params: {
          id: @supplier_to_update, 
          supplier: FactoryBot.attributes_for(:supplier, sup_type: "personal", name: "hoangdq", address: "Hung Yen")
        }
        @supplier_to_update.reload
        expect(@supplier_to_update.name).to eq "hoangdq"
        expect(@supplier_to_update.address).to eq "Hung Yen"
        expect(response).to be_redirect
      end

      it "should redirect to accountant_suppliers_path" do
        put :update, params: {
          id: @supplier_to_update.id,
          supplier: FactoryBot.attributes_for(:supplier, sup_type: "personal")
        }
        expect(response).to redirect_to accountant_suppliers_path
      end
    end

    context "with invalid attributes" do
      it "should not change supplier's attributes" do
        put :update, params: {
            id: @supplier_to_update,
            supplier: FactoryBot.attributes_for(:supplier, sup_type: "personal", taxNum: "123456")
        }
        @supplier_to_update.reload
        expect(@supplier_to_update.taxNum).to_not eq("123456")
      end

      it "should re-render accountant edit supplier page" do
        put :update, params: {
            id: @supplier_to_update,
            supplier: FactoryBot.attributes_for(:supplier, sup_type: "personal", taxNum: "123456")
        }
        expect(response).to render_template :edit
      end
    end
  end
end
