class AlterSubnetsAddUser < ActiveRecord::Migration
  def up
    add_column("subnets", "user_id", :integer, :null => false)
  end

  def down
    remove_column("subnets", "user_id")
  end
end
