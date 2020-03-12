class CreateStocks < ActiveRecord::Migration[6.0]
  def change
    create_table :stocks do |t|
      t.string :ticker
      t.decimal :price, precision: 1000, scale: 2
      t.integer :quantity
      t.string :color
      t.decimal :total, precision: 1000, scale: 2, :default => 0.00
      t.string :transactionType, :default => "BUY"
      t.timestamps
    end
  end
end
