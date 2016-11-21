# frozen_string_literal: true
class Product < ApplicationRecord
  serialize :options, Hash

  validates :name, presence: true, uniqueness: true
  validates :container_name, presence: true
  validates :item_name, presence: true
  validates :item_quantity, numericality: { greater_than: 0, only_integer: true }
  validate :options_are_in_valid_format

  # In a real application we'd keep this logic in a separate class.
  def serialize_for_order_form
    serializable_hash(only: %i(id name))
  end

  def self.serialize_for_order_form
    all.map(&:serialize_for_order_form)
  end

  private

  def options_are_in_valid_format
    unless options.is_a?(Hash) &&
           options.each_key.all? { |key| key.is_a?(String) } &&
           options.each_value.all? { |val|
             val.is_a?(Array) && val.all? { |option| option.is_a?(String) }
           }
      errors.add(:options, 'are not in a valid format')
    end
  end
end
