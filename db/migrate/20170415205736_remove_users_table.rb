class RemoveUsersTable < ActiveRecord::Migration
  def change
    drop_table :users, force: :cascade
  end
end
