class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string "title", :limit => 255, :null => false
      t.timestamps
    end
  end
end
