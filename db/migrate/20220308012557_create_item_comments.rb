class CreateItemComments < ActiveRecord::Migration[6.1]
  def change
    create_table :item_comments do |t|
      t.integer :end_user_id
      t.integer :item_id
      t.text :comment

      t.timestamps
    end
  end
end
