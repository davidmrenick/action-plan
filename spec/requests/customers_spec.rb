require 'rails_helper'

RSpec.describe "Customers", type: :request do
  describe "GET /customers" do
    let!(:customer) { Customer.create(first_name: 'Test', last_name: 'User', email_address: 'test@user.com', vehicle_type: 'bicycle', vehicle_name: 'test vehicle', vehicle_length: 30)}
    it "returns the list of customers" do
      get '/customers'
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(Customer.all.to_json)
    end
  end

  describe "GET /customers/:id" do
  let!(:customer) { Customer.create(first_name: 'Test', last_name: 'User', email_address: 'test@user.com', vehicle_type: 'bicycle', vehicle_name: 'test vehicle', vehicle_length: 30)}
    it "returns the specified customer" do
      get "/customers/#{customer.id}"
      expect(response).to have_http_status(:ok)
      expect(response.body).to eq(customer.to_json)
    end
  end

  describe "POST /customers" do
    context "valid attributes" do
      let!(:params) { {firstName: "Jim", lastName: "Henson", emailAddress: "jhenson@sesamestreet.org", vehicleType: "sailboat", vehicleName: "Kermit", vehicleLength: 60} }
      it "creates the specified customer" do
        post "/customers", params: params
        expect(response).to have_http_status(:ok)

        json = JSON.parse(response.body).deep_symbolize_keys
        expect(json[:firstName]).to eq('Jim')
        expect(json[:lastName]).to eq('Henson')
      end
    end
    context "invalid attributes" do
      let!(:bad_params) { {firstName: "Ferdinand", lastName: "Magellan", emailAddress: "fmagellan@explore.gov.pt", vehicleType: "sailboat", vehicleName: "Victoria", vehicleLength: 0} }
      it "returns a bad request and does not create the customer" do
        post "/customers", params: bad_params
        expect(response).to have_http_status(:bad_request)
      end

    end
  end

  describe "PATCH /customers/:id" do
    let(:customer) { Customer.create(first_name: 'Test', last_name: 'User', email_address: 'test@user.com', vehicle_type: 'bicycle', vehicle_name: 'test vehicle', vehicle_length: 30)}
    context "valid attributes" do
      it "updates the specified customer" do
        patch "/customers/#{customer.id}", params: {emailAddress: "test_user@gmail.com"}
        expect(response).to have_http_status(:ok)
        expect(customer.reload.email_address).to eq('test_user@gmail.com')
      end
    end
    context "invalid attributes" do
      it "does not update the customer and returns a bad request" do
        patch "/customers/#{customer.id}", params: {vehicleLength: 0}
        expect(response).to have_http_status(:bad_request)
        expect(customer.reload.vehicle_length).to_not eq(0)
      end
    end
  end

  describe "DELETE /customers/:id" do
    let!(:customer) { Customer.create(first_name: 'Test', last_name: 'User', email_address: 'test@user.com', vehicle_type: 'bicycle', vehicle_name: 'test vehicle', vehicle_length: 30)}
    it "returns the list of customers" do
      delete "/customers/#{customer.id}"
      expect(response).to have_http_status(:ok)
      expect{ customer.reload }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end

  describe "POST /customers/bulk" do
    let!(:path) { "#{Rails.root}/spec/fixtures/data.csv" }
    let!(:bad_path) { "#{Rails.root}/spec/fixtures/bad_data.csv" }
    context "with valid file contents" do
      it "creates customers based on the file contents" do
        expect { post "/customers/bulk", params: {file: Rack::Test::UploadedFile.new(path)} }.to change{ Customer.count }
        expect(response).to have_http_status(:ok)
      end
    end
    context "with invalid file contents" do
      it "does not create customers and returns a bad request" do
        expect { post "/customers/bulk", params: {file: Rack::Test::UploadedFile.new(bad_path)} }.to_not change { Customer.count }
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
