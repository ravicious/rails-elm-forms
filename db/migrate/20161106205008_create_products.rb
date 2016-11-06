class CreateProducts < ActiveRecord::Migration[5.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, index: { unique: true }
      t.string :container_name, null: false
      t.string :item_name, null: false
      t.integer :item_quantity, null: false
      t.text :options

      t.timestamps
    end
  end
end
