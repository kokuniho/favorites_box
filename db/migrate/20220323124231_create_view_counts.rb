class CreateViewCounts < ActiveRecord::Migration[6.1]
  def change
    create_table :view_counts do |t|
      t.integer :item_id
      t.integer :end_user_id

      t.timestamps
    end
  end
end
