class CreatePhones < ActiveRecord::Migration[7.1]
  def change
    create_table :phones do |t|
      t.timestamps
      t.references :person, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :label
      t.string :number
    end
  end
end
