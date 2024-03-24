class CreatePeople < ActiveRecord::Migration[7.1]
  def change
    create_table :people do |t|
      t.timestamps
      t.references :membership, null: false, foreign_key: true
      t.string :first_name
      t.string :last_name
      t.date :dob
      t.integer :birth_year
    end
  end
end
