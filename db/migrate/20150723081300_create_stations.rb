class CreateStations < ActiveRecord::Migration
  def change
    create_table :stations do |t|
      t.integer :given_id
      t.string :name
      t.float :longitude, {precision: 10, scale: 6}
      t.float :latitude, {precision: 10, scale: 6}
      t.integer :dpcapacity
      t.string :dateCreated

      t.timestamps null:false
    end
  end
end
