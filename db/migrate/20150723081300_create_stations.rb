class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :given_id
      t.string :name
      t.column :longitude, :latitude, precision: 9
      t.decimal :latitude
      t.integer :dpcapacity
      t.string :dateCreated

      t.timestamps null:false
  end
end
