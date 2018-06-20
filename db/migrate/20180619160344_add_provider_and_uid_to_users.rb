class AddProviderAndUidToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :provider, :string unless column_exists?(:users, :provider)
    add_column :users, :uid, :string  unless column_exists?(:users, :uid)
    add_index :users, [:uid, :provider], unique: true unless index_exists?(:users, [:uid, :provider], unique: true)
  end
end
