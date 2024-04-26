# == Schema Information
#
# Table name: customers
#
# id              :bigint   not null, primary key
# first_name      :string
# last_name       :string
# email_address   :string
# vehicle_type    :integer
# vehicle_name    :string
# vehicle_length  :integer
class Customer < ApplicationRecord
  enum vehicle_type: ['campervan', 'motorboat', 'bicycle', 'sailboat']

  validates :vehicle_length, comparison: { greater_than: 0 }
  validates :first_name, :last_name, :email_address, presence: true

  # Override default, formats outgoing json to have camelCased keys
  def as_json(options)
    hash = super(options)
    hash.transform_keys!{ |key| key.to_s.camelize(:lower) }
  end
end
