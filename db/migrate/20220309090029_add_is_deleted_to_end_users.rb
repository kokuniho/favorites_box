class AddIsDeletedToEndUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :end_users, :is_deleted, :boolean, default: false, null: false
  end
end
