class CreateAttendances < ActiveRecord::Migration[8.0]
  def change
    create_table :attendances do |t|
      t.references :student, null: false, foreign_key: true
      t.references :professional, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true
      t.date :date
      t.time :start_time
      t.time :end_time
      t.text :observations
      t.integer :created_by

      t.timestamps
    end
  end
end
