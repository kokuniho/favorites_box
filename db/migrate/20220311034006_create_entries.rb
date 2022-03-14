class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.bigint :end_user_id, foreign_key: true
      t.bigint :room_id, foreign_key: true


      t.timestamps
    end
  end
end
