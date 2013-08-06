class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message
      t.integer :user_id
      t.integer :recipient_id      
      t.boolean :status, :default => false
      t.timestamps
    end
  end
end
