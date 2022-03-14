class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.references :end_user, type: :bigint, foreign_key: true
      t.references :room, type: :bigint, foreign_key: true


      t.timestamps
    end
  end
end
