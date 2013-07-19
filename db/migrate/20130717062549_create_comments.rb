class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :activity_id
      t.string :user_id

      t.timestamps
    end
    add_index :comments, [:user_id, :created_at]
  end
end
