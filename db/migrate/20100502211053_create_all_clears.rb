class CreateAllClears < ActiveRecord::Migration
  def self.up
    create_table :all_clears do |t|
      t.string :location
      t.string :ip

      t.timestamps
    end
  end

  def self.down
    drop_table :all_clears
  end
end
