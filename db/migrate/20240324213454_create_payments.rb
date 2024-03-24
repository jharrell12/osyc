class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.timestamps
      t.references :invoice, null: false, foreign_key: true
      t.date :date
      t.integer :amount
      t.string :check_number
    end
  end
end
