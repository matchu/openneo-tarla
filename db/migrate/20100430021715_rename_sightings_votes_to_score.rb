class RenameSightingsVotesToScore < ActiveRecord::Migration
  def self.up
    rename_column :sightings, :votes_count, :score
  end

  def self.down
    rename_column :sightings, :score, :votes_count
  end
end
