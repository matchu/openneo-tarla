class CreateSightings < ActiveRecord::Migration
  def self.up
    create_table :sightings do |t|
      t.string :url
      t.string :ip
      t.integer :votes_count

      t.timestamps
    end
  end

  def self.down
    drop_table :sightings
  end
end
