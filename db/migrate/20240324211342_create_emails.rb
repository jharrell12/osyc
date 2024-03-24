class CreateEmails < ActiveRecord::Migration[7.1]
  def change
    create_table :emails do |t|
      t.timestamps
      t.references :person, null: false, foreign_key: true
      t.date :start_date
      t.date :end_date
      t.string :label
      t.string :address
    end
  end
end
