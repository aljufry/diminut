class CreateSubnets < ActiveRecord::Migration
  def change
    create_table :subnets do |t|
      t.string "name", :limit => 100, :null => false
      t.string "cidr", :limit => 20, :null => false
      t.string "description", :limit => 255
      t.timestamps
    end
  end
end
