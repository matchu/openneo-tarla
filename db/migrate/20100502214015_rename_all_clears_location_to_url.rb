class RenameAllClearsLocationToUrl < ActiveRecord::Migration
  def self.up
    rename_column :all_clears, :location, :url
  end

  def self.down
    rename_column :all_clears, :url, :location
  end
end
