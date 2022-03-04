class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|
      t.string :name
      t.text :body
      t.integer :end_user_id

      t.timestamps
    end
  end
end
