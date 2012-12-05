class CreateEntries < ActiveRecord::Migration
  def change
    create_table :entries do |t|
      t.references :user, :null => false
      t.references :subnet, :null => false
      t.string "server_name", :limit => 255, :null => false
      t.string "model", :limit => 255, :null => false
      t.string "operating_system", :limit => 100, :null => false
      t.string "serial_number", :limit => 255, :null => false
      t.string "ip", :limit => 15, :null => false
      t.date "warranty"
      t.string "public_ip", :limit => 15
      t.string "location", :limit => 200
      t.string "segment", :limit => 100
      t.string "application", :limit => 100
      t.string "username", :limit => 255
      t.string "password", :limit => 255
      t.text "remarks"

      t.timestamps
    end
  end
end
