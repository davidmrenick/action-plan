require 'csv'

class CustomersController < ApplicationController
  SORT_OPTS = ['type', 'firstName', 'lastName']
  CSV_HEADERS = ['first_name', 'last_name', 'email_address', 'vehicle_type', 'vehicle_name', 'vehicle_length']

  before_action :customer, only: [:show, :update, :destroy]

  # GET /customers
  # Returns list of all customers, formatted as json
  #
  # @param sort [String] the attribute to sort by, limited to options in SORT_OPTS, optional
  def index
    @customers = Customer.all
    if params[:sort]
      if params[:sort] == 'type'
        render json: @customers.order(:vehicle_type)
      elsif SORT_OPTS.include? params[:sort]
        render json: @customers.order(params[:sort].underscore)
      end
    else
      render json: @customers.order(created_at: :asc)
    end
  end

  # GET /customers/:id
  # Returns a single customer's data, formatted as json
  #
  # @param id [Integer] id of the customer to retrieve
  def show
    render json: @customer
  end

  #POST /customers
  # Creates a customer based on sent params, returns created customer formatted as json
  #
  # @param customer_params [Hash] the params to create a customer with
  # @option first_name [String] customer's first name
  # @option lastName [String] customer's last name
  # @option emailAddress [String] email address of the customer
  # @option vehicleType [String] the type of vehicle, limited to enum values in customer.rb
  # @option vehicleName [String] the name of the vehicle
  # @option vehicleLength [Integer] the length of the vehicle in feet
  def create
    @customer = Customer.new(customer_params)
    if @customer.valid?
      @customer.save
      render json: @customer
    else
      render error: { error: 'Unable to create customer' }, status: 400
    end
  end

  # PUT/PATCH /customers/:id
  # Updates a user based on sent params, returns updated customer formatted as json
  #
  # @param id [Integer] the id of the customer to update
  # @param customer_params [Hash] the params to create a customer with
  # @option first_name [String] customer's first name
  # @option lastName [String] customer's last name
  # @option emailAddress [String] email address of the customer
  # @option vehicleType [String] the type of vehicle, limited to enum values in customer.rb
  # @option vehicleName [String] the name of the vehicle
  # @option vehicleLength [Integer] the length of the vehicle in feet
  def update
    if @customer
      if @customer.update(customer_params)
        render json: @customer, status: 200
      else
        render error: { error: 'Unable to update user'}, status: 400
      end
    else
      render error: { error: 'Customer not found' }, status: 400
    end
  end

  # DELETE /customers/:id
  # Destroys a specified user based on id, returns message denoting successful deletion
  #
  # @param id [Integer] id of the customer to be deleted
  def destroy
    if @customer
      @customer.destroy
      render json: { message: 'Customer successfully deleted' }, status: 200
    else
      render error: { error: 'Customer not found' }, status: 400
    end
  end

  # POST /customers/bulk
  # Receives a csv file of users to create, creates each customer in the list
  #
  # @param file [File] the csv file to be processed, sent as multipart/form-data
  def bulk
    CSV.foreach(params[:file].path, headers: CSV_HEADERS) do |row|
      row['vehicle_length'] = row['vehicle_length'].delete("^0-9")
      cust = Customer.new(row)
      if !cust.valid?
        render error: { error: 'Unable to create customer' }, status: 400 and return
      end
      cust.save
    end
    render json: { message: 'Customers successfully created' }, status: 200
  end

  def customer_params
    params.permit('id', 'firstName', 'lastName', 'emailAddress', 'vehicleType', 'vehicleName', 'vehicleLength').transform_keys!(&:underscore)
  end

  def customer
    @customer = Customer.find(params[:id])
  end
end
