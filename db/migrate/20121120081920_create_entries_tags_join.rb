class CreateEntriesTagsJoin < ActiveRecord::Migration
  def up
    create_table :entries_tags, :id => false do |t|
      t.integer "entry_id"
      t.integer "tag_id"
    end 
    add_index :entries_tags, ["entry_id", "tag_id"]
  end

  def down
    drop_table :entries_tags
  end
end
