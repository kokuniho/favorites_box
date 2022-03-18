class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.bigint :room_id, foreign_key: true
      t.bigint :message_id, foreign_key: true
      t.bigint :item_id, foreign_key: true
      t.bigint :item_comment_id, foreign_key: true
      t.boolean :checked, default: false, null: false
      t.string :action

      t.timestamps
    end
  end
end
