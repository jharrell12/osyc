class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.timestamps
      t.references :person, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :label
      t.string :street
      t.string :city
      t.string :state
      t.string :zipcode
    end
  end
end
