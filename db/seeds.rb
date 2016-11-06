# frozen_string_literal: true
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Product.transaction do
  [
    {
      name: 'Soccer balls bag',
      container_name: 'bag',
      item_name: 'ball',
      item_quantity: 5,
    },
    {
      name: 'Tea',
      container_name: 'pack',
      item_name: 'bag',
      item_quantity: 20,
      options: {
        'kind' => %w(white green oolong black pu-erh),
      },
    },
    {
      name: 'Mug 3-pack',
      container_name: 'pack',
      item_name: 'mug',
      item_quantity: 3,
      options: {
        'size' => %w(big medium small),
      }
    }
  ].each do |product_attributes|
    Product.where(name: product_attributes.fetch(:name)).first_or_create! do |new_product|
      new_product.attributes = product_attributes
    end
  end
end
