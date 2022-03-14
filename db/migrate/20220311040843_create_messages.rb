class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :message
      t.bigint :end_user_id, foreign_key: true
      t.bigint :room_id, foreign_key: true

      t.timestamps
    end
  end
end
