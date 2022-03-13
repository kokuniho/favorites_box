class CreateMessages < ActiveRecord::Migration[6.1]
  def change
    create_table :messages do |t|
      t.text :message
      t.references :end_user, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
