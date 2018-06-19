class RemoveAuthTokenFromUsers < ActiveRecord::Migration[5.1]
  def change
     remove_index :users, :auth_token
     remove_column :users, :auth_token
  end
end
