class AddUniqueIndexToCounty < ActiveRecord::Migration
  def change
    remove_index :counties, :name
    add_index :counties, :name, :unique => true
  end
end
