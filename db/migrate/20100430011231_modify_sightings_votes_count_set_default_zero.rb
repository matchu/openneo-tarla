class ModifySightingsVotesCountSetDefaultZero < ActiveRecord::Migration
  def self.up
    change_column :sightings, :votes_count, :integer, :null => false, :default => 0
  end

  def self.down
    change_column :sightings, :votes_count, :integer
  end
end
