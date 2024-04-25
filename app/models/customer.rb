class Customer < ApplicationRecord
  enum vehicle_type: ['campervan', 'motorboat', 'bicycle', 'sailboat']

  validates :vehicle_length, comparison: { greater_than: 0 }

  def as_json(options)
    {
      'id': id,
      'firstName': first_name,
      'lastName': last_name,
      'emailAddress': email_address,
      'vehicleType': vehicle_type,
      'vehicleName': vehicle_name,
      'vehicleLength': vehicle_length
    }
  end
end
