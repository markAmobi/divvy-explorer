class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :given_id
      t.string :name
      t.decimal :longitude, :decimal, precision: 9
      t.decimal :latitude, :decimal, precision: 9
      t.integer :dpcapacity
      t.string :dateCreated

      t.timestamps null:false
    end
  end
end
