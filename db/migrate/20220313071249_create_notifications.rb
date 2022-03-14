class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.bigint :room_id, foreign_key: true, null: false
      t.bigint :message_id, foreign_key: true, null: false
      t.boolean :checked, default: false, null: false
      t.string :action

      t.timestamps
    end
  end
end
