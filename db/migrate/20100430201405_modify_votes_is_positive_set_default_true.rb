class ModifyVotesIsPositiveSetDefaultTrue < ActiveRecord::Migration
  def self.up
    change_column :votes, :is_positive, :boolean, :null => false, :default => true
  end

  def self.down
    change_column :votes, :is_positive, :boolean, :null => false
  end
end
