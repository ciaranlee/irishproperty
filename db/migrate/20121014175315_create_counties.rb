class CreateCounties < ActiveRecord::Migration
  def change
    create_table :counties do |t|
      t.string :name, :null => false
      t.timestamps
    end

    add_index :counties, :name

    add_column :sales, :county_id, :integer, :null => false, :default => 0
    add_index :sales, :county_id
    remove_index :sales, :county
    remove_column :sales, :county
  end
end
