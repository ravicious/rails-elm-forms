# frozen_string_literal: true
class CreateOrders < ActiveRecord::Migration[5.0]
  def change
    create_table :orders do |t|
      t.references :product, index: true, foreign_key: true, null: false
      t.integer :quantity, null: false
      t.text :options
      t.decimal :unit_price, null: false, precision: 8, scale: 2
      t.decimal :shipping_price, null: false, precision: 8, scale: 2
      t.text :customer_name, null: false, default: ''
      t.text :customer_email, null: false, default: ''

      t.timestamps
    end
  end
end
