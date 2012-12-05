class AlterUserAddSalt < ActiveRecord::Migration
  def up
    add_column("users", "salt", :string, :limit => 100, :null => false)
  end

  def down
    remove_column("users", "salt")
  end
end
