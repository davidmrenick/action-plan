class Customer < ApplicationRecord
  enum vehicle_type: ['campervan', 'motorboat', 'bicycle', 'sailboat']

  def as_json(options)
    {
      'firstName': first_name,
      'lastName': last_name,
      'emailAddress': email_address,
      'vehicleType': vehicle_type,
      'vehicleName': vehicle_name,
      'vehicleLength': vehicle_length
    }
  end
end
