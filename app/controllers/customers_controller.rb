class CustomersController < ApplicationController

  SORT_OPTS = ['type', 'firstName', 'lastName']
  CSV_HEADERS = ['first_name', 'last_name', 'email_address', 'vehicle_type', 'vehicle_name', 'vehicle_length']

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

  def show
    @customer = Customer.find(params[:id])
    render json: @customer
  end

  def create
    @customer = Customer.new(customer_params)
    if @customer.save
      render json: @customer
    else
      render error: { error: 'Unable to create customer' }, status: 400
    end
  end

  def update
    @customer = Customer.find(customer_params[:id])
    if @customer
      if @customer.update(customer_params)
        render json: {message: 'User updated successfully!' }, status: 200
      else
        render error: { error: ''}, status: 400
      end
    else
      render error: { error: 'Customer not found' }, status: 400
    end
  end

  def destroy
    @customer = Customer.find(params[:id])
    if @customer
      @customer.destroy
      render json: { message: 'Customer successfully deleted' }, status: 200
    else
      render error: { error: 'Customer not found' }, status: 400
    end
  end

  def bulk
    CSV.foreach(params[:file], headers: CSV_HEADERS) { |row| Customer.upsert(row) }
  end

  def customer_params
    params.permit('id', 'firstName', 'lastName', 'emailAddress', 'vehicleType', 'vehicleName', 'vehicleLength').transform_keys!(&:underscore)
  end
end
