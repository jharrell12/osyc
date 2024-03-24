class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.timestamps
      t.references :membership, null: false, foreign_key: true
      t.string :status
      t.datetime :posted_date
      t.date :due_date
      t.integer :balance_due
    end
  end
end
