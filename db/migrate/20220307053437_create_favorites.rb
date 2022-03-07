class CreateFavorites < ActiveRecord::Migration[6.1]
  def change
    create_table :favorites do |t|
      t.integer :end_user_id
      t.integer :item_id

      t.timestamps
      t.index [:end_user_id, :item_id], unique: true
    end
  end
end
