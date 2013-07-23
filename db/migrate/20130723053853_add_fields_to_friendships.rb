class AddFieldsToFriendships < ActiveRecord::Migration
  def change
    add_column :friendships, :status, :boolean,:default => false
  end
end
