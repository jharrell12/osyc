class CreateMemberships < ActiveRecord::Migration[7.1]
  def change
    create_table :memberships do |t|
      t.timestamps
      t.date :start_date
      t.date :end_date
      t.string :status
      t.string :boats
      t.string :slip_assignment
      t.string :children
    end
  end
end
