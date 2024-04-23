class CustomersController < ApplicationController

  def index
    @customers = Customer.all
    if customer_params[:sort]
      render json: @customers.order(customer_params[:sort])
    else
      render json: @customers.order(created_at: :asc)
    end
  end

  def show
    @customer = Customer.find(customer_params[:id])
    render json: @customer.transform_keys { |key| key = key.camelize }
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
    abort customer_params
    @customer = Customer.new(customer_params[:id])
    if @customer
      if user.update(customer_params)
        render json: {message: 'User updated successfully!' }, status: 200
      else
        render error: { error: ''}, status: 400
      end
    else
      render error: { error: 'Customer not found' }, status: 400
    end
  end

  def destroy
    @customer = Customer.find(customer_params[:id])
    if @customer
      @customer.destroy
      render json: { message: 'Customer successfully deleted' }, status: 200
    else
      render error: { error: 'Customer not found' }, status: 400
    end
  end

  def bulk

  end

  def customer_params
    params.permit('firstName', 'lastName', 'emailAddress', 'vehicleType', 'vehicleName', 'vehicleLength').transform_keys!(&:underscore)
  end

end
