# frozen_string_literal: true
class Order < ApplicationRecord
  serialize :options, Hash

  belongs_to :product

  validates :quantity, numericality: { greater_than: 0, only_integer: true }
  validates :unit_price, numericality: { greater_than_or_equal_to: 0 }
  validates :shipping_price, numericality: { greater_than_or_equal_to: 0 }
  # Simple email regexp to ensure there's a @ and a dot after it.
  validates :customer_email, format: { with: /\A\S+@\S+\.\S+\Z/, allow_nil: true }

  validate :both_customer_fields_are_present_or_none_is
  validate :options_include_valid_keys
  validate :options_include_valid_values

  def total_price
    quantity * unit_price + shipping_price
  end

  private

  def both_customer_fields_are_present_or_none_is
    if customer_name.blank? && customer_email.present?
      errors.add(:customer_name, 'must be present along with customer email')
    end

    if customer_email.blank? && customer_name.present? # rubocop:disable Style/GuardClause
      errors.add(:customer_email, 'must be present along with customer name')
    end
  end

  # rubocop:disable Style/Next
  def options_include_valid_keys
    return unless product

    options.each_key do |key|
      if !product.options.each_key.include?(key)
        errors.add(
          :options,
          "include an option #{key.inspect} which is not available for #{product.name}"
        )
      end
    end
  end
  # rubocop:enable Style/Next

  # rubocop:disable Style/Next
  def options_include_valid_values
    return unless product

    options.each do |key, value|
      # `options_include_valid_keys` should handle incorrect keys.
      next unless product.options.each_key.include?(key)

      possible_option_values = product.options.fetch(key)

      if !possible_option_values.include?(value)
        errors.add(
          :options,
          "include an unavailable value #{value.inspect} for the option #{key.inspect}"
        )
      end
    end
  end
  # rubocop:enable Style/Next
end
