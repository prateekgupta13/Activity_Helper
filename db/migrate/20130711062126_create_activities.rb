class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.string :category
      t.string :name
      t.string :description
      t.string :user_id

      t.timestamps
    end
     add_index :activities, [:user_id, :created_at]
  end
end
