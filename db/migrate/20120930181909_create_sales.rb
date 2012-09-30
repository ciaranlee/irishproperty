class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.datetime :date
      t.string :address
      t.string :postal_code
      t.string :county
      t.string :price_string
      t.integer :price
      t.boolean :full_market_price
      t.string :description
      t.string :size_description
      t.decimal :lat
      t.decimal :lng
      t.string :import_hash, :null => false
      t.timestamps
    end
    add_index(:sales, :import_hash, :unique => true)
  end
end
