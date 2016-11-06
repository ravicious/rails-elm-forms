class Product < ApplicationRecord
  serialize :options, Hash

  validates :name, presence: true, uniqueness: true
  validates :container_name, presence: true
  validates :item_name, presence: true
  validates :item_quantity, numericality: { greater_than: 0, only_integer: true }
  validate :options_are_in_valid_format

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
