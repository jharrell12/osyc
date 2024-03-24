class CreateCharges < ActiveRecord::Migration[7.1]
  def change
    create_table :charges do |t|
      t.timestamps
      t.references :invoice, null: false, foreign_key: true
      t.string :description
      t.integer :price
    end
  end
end
