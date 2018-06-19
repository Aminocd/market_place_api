class CreateWhitelistedJwts < ActiveRecord::Migration[5.1]
  def change
    #Ben 6/16/2018 This table will allow users to be signed in with multiple devices
   create_table :whitelisted_jwts do |t|
     t.string :jti, null: false
     t.string :aud
     # If you want to leverage the `aud` claim, add to it a `NOT NULL` constraint:
     # t.string :aud, null: false
     t.datetime :exp, null: false
     t.references :user, foreign_key: { on_delete: :cascade }, null: false
   end
   add_index :whitelisted_jwts, :jti, unique: true
  end
end
