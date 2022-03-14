class CreateNotifications < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :visitor_id, null: false
      t.integer :visited_id, null: false
      t.references :room, type: :bigint, foreign_key: true, null: false
      t.references :message, type: :bigint, foreign_key: true, null: false
      t.boolean :checked, default: false, null: false
      t.string :action

      t.timestamps
    end
  end
end
